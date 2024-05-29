cwlVersion: v1.2
class: Workflow
id: hydromt-workflow
requirements:
  - class: StepInputExpressionRequirement
inputs:
  - id: res
    type: float
  - id: precip_fn
    type: string
  - id: region
    type: string
  - id: catalog
    type: File
  - id: volume_data
    type: Directory
outputs:
  - id: model
    type: Directory
    outputSource: build-hydromt/model
steps:
  - id: update-config
    in:
      - id: res
        source: res
      - id: precip_fn
        source: precip_fn
    out: [setupconfig]
    run:
      class: CommandLineTool
      baseCommand: update
      inputs:
        - id: res
          type: float
          inputBinding:
            position: 1
        - id: precip_fn
          type: string
          inputBinding:
            position: 2
      outputs:
        - id: setupconfig
          type: File
          outputBinding:
            glob: "wflow.ini"
      requirements:
        DockerRequirement:
          dockerPull: potato55/hydromt:vienna
          dockerOutputDirectory: /hydromt
        NetworkAccess:
          class: NetworkAccess
          networkAccess: true
  - id: build-hydromt
    in:
      - id: region
        source: region
      - id: setupconfig
        source: update-config/setupconfig
      - id: catalog
        source: catalog
      - id: volume_data
        source: volume_data
    out: [model]
    run:
      class: CommandLineTool
      baseCommand: build
      inputs:
        - id: region
          type: string
          inputBinding:
            position: 1
        - id: setupconfig
          type: File
          inputBinding:
            position: 2
        - id: catalog
          type: File
          inputBinding:
            position: 3
        - id: volume_data
          type: Directory
          inputBinding:
            position: 4
      outputs:
        - id: model
          type: Directory
          outputBinding:
            glob: .
      requirements:
        DockerRequirement:
          dockerPull: potato55/hydromt:vienna
          dockerOutputDirectory: /hydromt
        InitialWorkDirRequirement:
          listing:
            - entryname: /data
              entry: $(inputs.volume_data)
        NetworkAccess:
          class: NetworkAccess
          networkAccess: true
