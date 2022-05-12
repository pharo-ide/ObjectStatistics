# ObjectStatistics

[![GitHub release](https://img.shields.io/github/release/pharo-ide/ObjectStatistics.svg)](https://github.com/pharo-ide/ObjectStatistics/releases/latest)
[![Unit Tests](https://github.com/pharo-ide/ObjectStatistics/actions/workflows/tests.yml/badge.svg)](https://github.com/pharo-ide/ObjectStatistics/actions/workflows/tests.yml)

[![Pharo 7.0](https://img.shields.io/badge/Pharo-7.0-informational)](https://pharo.org)
[![Pharo 8.0](https://img.shields.io/badge/Pharo-8.0-informational)](https://pharo.org)
[![Pharo 9.0](https://img.shields.io/badge/Pharo-9.0-informational)](https://pharo.org)
[![Pharo 10](https://img.shields.io/badge/Pharo-10-informational)](https://pharo.org)
[![Pharo 11](https://img.shields.io/badge/Pharo-11-informational)](https://pharo.org)

ObjectStatistics is tool to analyse set of objects by computing different kind of metrics and look at them from different angles.

Imaging that we have collection of message sends and we want to know number of message sends in dimension of receiver, receiver class and message selector. We have different angles to look at this data: from receiver class to selector and receiver or from selector to receiver class and receiver or any other combination. 

We also could analyze different kind of metrics which could be computed on given objects. It could be number of unique receivers, execution time, executed lines of code, etc.

This package implements computation of object statistics over declared metrics and dimensions space.

Described example could be look like:
```Smalltalk
stat := ObjectStatistics new.
stat
  countAllAs: 'sends';
  countDifferent: [ :message | message receiver ] as: 'instances'.
stat 
  dimension: [ :message | message receiver class ] named: 'classes';
  with: [ 
    stat dimension: [ :message | message selector ] named: 'msgs';
    with: [ 
      stat dimension: [ :r | r ] named: 'receivers']];
  dimension: [ :message | message selector ] named: 'msgs';
  with: [ 
    stat dimension: [ :message | message receiver class ] named: 'classes';
    with: [ 
        stat dimension: [ :r | r ] named: 'receivers']].
			
stat accumulateAll: messageSends
 ```
## Installation
```Smalltalk
Metacello new
  baseline: 'ObjectStatistics';
  repository: 'github://pharo-ide/ObjectStatistics';
  load
```
Use following snippet for stable dependency in your project baseline:
```Smalltalk
spec
    baseline: 'ObjectStatistics'
    with: [ spec repository: 'github://pharo-ide/ObjectStatistics:v1.0.0' ]
```
