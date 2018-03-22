# Usage

### Create Vivado Project
```
cd prj/
./create_vivado_project.sh

```

### Open Vivado Project
```
cd prj/
vivado -nolog -nojournal netlistGen/netlistGen.xpr &
```

### Run Simulation
Inside vivado GUI click on the "Run Simulation" button,
the settings are configured to use the Questa Advanced Simulator,
but you could change them for you preferred ones

### Create Simulation Data Set
If you would like to create a new data set use
```
cd prj
./generateTBData.py > input_data_float.txt

```
