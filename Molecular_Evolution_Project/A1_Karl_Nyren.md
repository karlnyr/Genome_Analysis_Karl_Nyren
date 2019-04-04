#Assignment 1 - Karl Nyrén
Im thi lab we will go through the basic usage of Hadoop/MapReduce models.

## Task 1

### Task 1.1
In the follwoding answer I rand the following code:

```shell
$ usr/local/hadoop/bin/hadoop jar /usr/local/hadoop/share/hadoop/mapreduce/hadoop*examples*.jar wordcount input output
```

Questions:
1. Lets look at the directory in output:
```shell
$ ls /home/ubuntu/output
_SUCCESS  part-r-00000
$ less part-r-00000
"A"      2
"Alpha"  1
"Alpha,"        1
"An"     2
"And"    1
"BOILING"       2
"Batesian"      1
"Beta"   2
"Beta"  1
.
..
...
```
The _SUCCESS file is an automatic output from MapReduce runtime, inticating that everything has gone as planned. The part-r-00000 file is containing the counted words inside the input document, probably only seen as separated by white spaces. 
2. __Standalone__ mode is used more for debugging of the process, and is not using HDSF or YARN to create a cluster like environment. __Pseudo-Distributed__ mode is going to act more like an actual cluster environment, initiation a master and slave setup, where the Java process is run on the backend.


