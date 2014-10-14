CMSSW-benchmarks
================

Please mind that I had to spend very little time on this. Still it works. If you think of improvements please send pull requests or issues.

To make this work you need :

```
[root@compute-opteron-11 bm]# wget --no-check-certificate https://github.com/samircury/CMSSW-benchmarks/archive/master.zip

[root@compute-opteron-11 CMSSW-benchmarks-master]# chmod +x benchmark.sh  run.sh 
```

Define your proxy here if you need "export https_proxy=http://hn:3128"

[root@compute-opteron-11 CMSSW-benchmarks-master]# source benchmark.sh 
```
[root@compute-opteron-11 CMSSW-benchmarks-master]# ps aux | grep cmsRun
root     15702 17.4  1.7 446708 288360 pts/1   S    08:24   0:23 cmsRun -e ../PSet.py
root     15705 17.6  1.8 446960 305372 pts/1   S    08:24   0:23 cmsRun -e ../PSet.py
root     15708 17.8  1.7 446452 280724 pts/1   S    08:24   0:23 cmsRun -e ../PSet.py
root     15712 17.8  1.7 446192 281812 pts/1   S    08:24   0:23 cmsRun -e ../PSet.py
root     15722 16.8  1.6 446192 272384 pts/1   S    08:24   0:22 cmsRun -e ../PSet.py
root     15726 16.7  1.6 446708 271996 pts/1   S    08:24   0:22 cmsRun -e ../PSet.py
root     15729 16.5  1.6 446448 270544 pts/1   S    08:24   0:22 cmsRun -e ../PSet.py
root     15732 16.7  1.7 446452 282068 pts/1   S    08:24   0:22 cmsRun -e ../PSet.py
```

It wil start 1 CMS job per core in the node, so you want to shutdown your batch system. results will be under "run1/CMSSW_5_3_8_patch3/src/${JOB_ID}/" directory. In Opteron 6378 it uses to last around 3h for 300 events.

To monitor what jobs are doing :

```
[root@compute-opteron-11 CMSSW-benchmarks-master]# tail -n200 run1/CMSSW_5_3_8_patch3/src/0/nohup.out 
[root@compute-opteron-11 CMSSW-benchmarks-master]# 
```
Afterwards I just grep the interesting parts of the FJR.

You might need to have the cmsenv setup already (just cmsrel on /tmp would be enough). 
