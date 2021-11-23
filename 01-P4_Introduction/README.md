# P4 Tutorial

## Introduction

Welcome to the first exercise. This week, we begin learning P4 and getting proficient in P4 programming.

The P4 exercises serve two purposes:
* By programming P4, we hands-on understand specific challenges in the Internet. As an example, we will program traffic engineering and load-balancing in P4. While doing this, we will comprehend the concepts better.
* By following and practicing these exercises, we prepare for the final project.

Let's begin with an introduction to our programming environment, development framework, and toolchain. Then, we can already start coding the cornerstones of the Internet!

### Exercise Planning

What we envisioned so far is as follows (please let us know if you have a better idea):

* The responsible host TA of the week presents the exercise,
* Then, general questions are discussed,
* If you have a personal question (you need to indicate that), we assign you to one of that week's TAs. You can ask your question in the MS Teams `#Labs` channel if you are remotely joining.
* After the exercise session, you can always visit our MS Teams `#Labs` channel for further questions.

Before we proceed, please open the following in your browsers:
* [Course Gitlab Repository](https://gitlab.ethz.ch/nsg/public/adv-net-2021)

## Development Tools

### Mininet Environment

Mininet creates a realistic virtual network, running actual kernel, switch, and application code on a single machine.

In our exercises, thanks to [P4-Utils](#p4-utils), we will not directly interact with Mininet most of the time since automated scripts will build the necessary topology for us.
When we need to know specific Mininet CLI commands, we will introduce them in the exercise.

<!--
Nevertheless, we recommend you check [here](https://github.com/nsg-ethz/p4-learning/tree/master/documentation/mininetless); an example that shows how to run a small virtual network topology without using Mininet. The script will let you understand what Mininet does behind the curtain.-->

In short, Mininet creates hosts using Unix namespaces and interconnects them using virtual interfaces and BMv2 switches. Linux namespaces provide a network stack for all the processes running within a specific namespace. Thus, network virtualization tools such as Mininet uses Linux network namespaces to instantiate isolated nodes in a topology (hosts, switches, routers, etc.).

### BMv2 Switch

Behavioral Model version 2 (BMv2) is the second version of the reference P4 software switch. Please refer to our [documentation](https://github.com/nsg-ethz/p4-learning/wiki/BMv2-Simple-Switch) for the details.

### Control Plane

After we build and run the BMv2 software switch, we can use the Simple Switch CLI to configure the switch and populate match-action tables.
To learn more about the Control Plane and its functions, please refer [here](https://github.com/nsg-ethz/p4-learning/wiki/Control-Plane).

### Scapy

Scapy is a packet manipulation library written in Python. Please check [here](https://github.com/nsg-ethz/p4-learning/wiki/Scapy) for further information.
We will use Scapy for generating and capturing packets at end hosts in our exercises.

### Debugging and Troubleshooting

Traffic sniffing can be very useful to debug your P4 program. To sniff the traffic that is going through an interface, we will use `tcpdump`. Please refer [here](https://github.com/nsg-ethz/p4-learning/wiki/Debugging-and-Troubleshooting) if you are interested in other similar tools or learning more about debugging and troubleshooting.

To capture binary-level traffic with `tcpdump` run:

```bash
sudo tcpdump -XX -i <interface_name>
```

### P4-Utils

P4-Utils is an extension to Mininet that makes P4 networks easier to build, run, and debug. Please refer to the [documentation](https://nsg-ethz.github.io/p4-utils/index.html) for the details.

### p4app.json

`p4app.json` describes the topology that we want to create with the help of Mininet and the P4-Utils package.
To create the topology described in `p4app.json`, you have to call `p4run`, which by default will check if the file `p4app.json` exists in the path:

   ```bash
   sudo p4run
   ```
This will call a Python script that parses the configuration file, creates a virtual network of hosts and p4 switches using Mininet, compiles the P4 program, and loads it in the switch.

After running `p4run` you will get the Mininet CLI prompt.

### P4 References

1. [P4 Spec](https://p4.org/specs/): P4 Language and Related Specifications
2. [P4-guide](https://github.com/jafingerhut/p4-guide): Repository that contains a lot of useful information, examples, and tests of best practices, tips, and tricks.
3. [P4 Tutorials](https://github.com/p4lang/tutorials): Official P4 Tutorials

## This week's exercises

This week covers two simple P4 tutorials. 

### Tutorial 1: Reflector

In this first tutorial, you will program and build a P4 switch that bounces back the packets that it receives. By doing that, you will also learn to create a simple topology.

Navigate into the tutorial's directory:

```bash
cd ~/adv-net-2021/01-P4_Introduction/01-Reflector
```

In that directory, you will find a `README` specific to that exercise (also [available online](https://gitlab.ethz.ch/nsg/public/adv-net-2021/-/blob/main/01-P4_Introduction/01-Reflector/README.md)). Follow the `README` to solve the exercise.

### Tutorial 2: Repeater

In this second tutorial, you will program and build a simple P4 switch that will forward packets between two hosts.

```bash
cd ~/adv-net-2021/01-P4_Introduction/02-Repeater
```

In that directory, you will find a `README` specific to that exercise (also [available online](https://gitlab.ethz.ch/nsg/public/adv-net-2021/-/blob/main/01-P4_Introduction/02-Repeater/README.md)). Follow the `README` to solve the exercise .

<!--## First Week Exercises

Let's have a tour in your VMs...

Go down to your home directory:

```bash
p4@Advnet:/home$
```

Then,

```bash
p4@Advnet:/home$ cd p4/
p4@Advnet:~$ cd p4-tools/
p4@Advnet:~/p4-tools$ cd p4-learning/
p4@Advnet:~/p4-tools/p4-learning$
```

`~/p4-learning/` is our local copy of the [P4-Learning Repository](https://github.com/nsg-ethz/p4-learning).

In the `~/p4-learning/documentation/` directory, you will find the necessary documentation, and we will point to that folder in the `README` of our exercises. Please go through them later on by yourself.

In the `~/p4-learning/examples/` directory, you will find the generic examples and their solutions that we put together for hands-on P4 learning. We advise you to practice them when you have time.

In the `~/p4-learning/exercise/` directory, you will find the previous years' exercises and solutions. This serves the same purpose with the `../examples/` folder that we explained above. Other than that, this week, we will use some of the exercises in this directory for our tutorials.

As the final step, let's start the Tutorials:

#### Tutorial 1: Reflector

In this first exercise, we will program and build a P4 switch that bounces back the packets that it receives. By doing that, we will also learn to create a simple topology.

Please get into the directory as shown below:

```bash
p4@Advnet:~$ cd p4-tools/p4-learning/exercises/01-Reflector/
```

In that directory, you will find a `README` specific to that exercise. Follow the `README` to solve the exercise ([here](https://github.com/nsg-ethz/p4-learning/blob/master/exercises/01-Reflector/README.md) is the online copy).

#### Tutorial 2: Repeater

In this exercise, we will program and build a simple P4 switch that will forward packets between two hosts.

```bash
p4@Advnet:~$ cd p4-tools/p4-learning/exercises/02-Repeaters/
```

In that directory, you will find a `README` specific to that exercise. Follow the `README` to solve the exercise ([here](https://github.com/nsg-ethz/p4-learning/blob/master/exercises/02-Repeater/README.md) is the online copy).

#### Tutorial 3: L2 Basic Forwarding

In this exercise, we will implement a basic layer 2 forwarding switch. The switch will statically map MAC addresses to ports and will use this mapping for forwarding.

```bash
p4@Advnet:~$ cd p4-tools/p4-learning/exercises/03-L2_Basic_forwarding/
```

In that directory, you will find a `README` specific to that exercise. Follow the `README` to solve the exercise ([here](https://github.com/nsg-ethz/p4-learning/blob/master/exercises/03-L2_Basic_forwarding/README.md) is the online copy).

#### Tutorial 4: L2 Flooding

In the previous exercise we implemented an L2 forwarding switch that forwards packets based on the static MAC addresses. In this exercise, we will implement a switch that can also broadcast packets in case the forwarding information is unknown.

```bash
p4@Advnet:~$ cd p4-tools/p4-learning/exercises/03-L2_Flooding/
```

In that directory, you will find a `README` specific to that exercise. Follow the `README` to solve the exercise ([here](https://github.com/nsg-ethz/p4-learning/tree/master/exercises/03-L2_Flooding) is the online copy).

#### Tutorial 5: L2 learning

This is the last exercise of our Basic L2 Switch series. In this exercise, we will make the switch a bit smarter and add the capability of autonomously learning MAC addresses to port mappings.

```bash
p4@Advnet:~$ cd p4-tools/p4-learning/exercises/04-L2_Learning/
```

In that directory, you will find a `README` specific to that exercise. Follow the `README` to solve the exercise ([here](https://github.com/nsg-ethz/p4-learning/tree/master/exercises/04-L2_Learning) is the online copy).-->
