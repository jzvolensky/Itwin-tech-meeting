# InterTwin 4th Plenary Tech Meeting Vienna

## Contents

The `example` directory contains all of the code, DockerFile setup etc. to build and run the example application.

The `cwl` directory contains the CWL workflow and parameter definition to execute the example application.

## Setup

Before running the `cwl_demo.ipynb` notebook, you need to install the environemnt to run `cwltool` locally.

```zsh
conda env create -f environment.yml
```

This command will create a virtual environment called `itwintechcwl` which contains all dependencies for development and execution.

Activate the environment:

```zsh
conda activate itwintechcwl
```

If you are using Visual Studio Code, you can select the environment in the editor.

## Running the CWL Workflow

Follow the instructions in the `cwl_demo.ipynb` notebook to run the CWL workflow.

## License

MIT License

## Authors

- Juraj Zvolensky
  - GitHub: @jzvolensky
  - Email: juraj.zvolensky@eurac.edu
  - Affiliation: EURAC Research
