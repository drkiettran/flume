# CISC 525 Apache Flume Project

## Running a Flume agent

### source spooldir - channel file - sink logger

```bash
mkdir /tmp/spooldir

flume-ng agent --conf-file spool-to-logger.properties --name agent1 --conf $FLUME_HOME/conf -Dflume.root.logger=INFO,console

```

Wait for the agent to get started. Then, run this:

```bash
echo "hello, world!" > /tmp/spooldir/file1.txt
echo "hello, USA!" > /tmp/spooldir/file2.txt
echo "hello, Pennsylvania, USA!" > /tmp/spooldir/file3.txt
echo "hello, Harrisburg, PA, USA!" > /tmp/spooldir/file4.txt
echo "hello, Harrisburg University of Science and Technologies, PA, USA!" > /tmp/spooldir/file5.txt
```

After each run of the above commands, verify the output in the log file.

### source exec with tail -F ... - channel memory - sink hdfs

```bash
flume-ng agent --conf-file tail-in-memory-hdfs.conf --name agent1 --conf $FLUME_HOME/conf -Dflume.root.logger=INFO,console
```

Watch the logs file from your own tail -F command:

```bash
tail -F /usr/local/hadoop/logs/hadoop-student-namenode-student-VirtualBox.log
```

When you see output from the above log, you should verify that you see the same text 
from one of the file under Hadoop stored under /tmp/system.log directory.

### Capturing ActiveMQ logs into HDFS

```bash
flume-ng agent --conf-file activemq-memory-hdfs.conf --name activemq_agent --conf $FLUME_HOME/conf -Dflume.root.logger=INFO,console

hdfs dfs -ls /tmp/activemq.log | awk '{print $8}' | while read f; do hdfs dfs -cat $f | grep -i hello && echo $f; done
```
