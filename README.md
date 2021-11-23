# Advanced Topics in Communication Networks 2021

Welcome to the Advanced Topics in Communication Networks Repository!
Here you will find the weekly exercises and instructions on how to run these exercises in a virtual environment.

<!-- TOC depthTo:3 -->

- [Advanced Topics in Communication Networks 2021](#advanced-topics-in-communication-networks-2021)
  - [How to start?](#how-to-start)
    - [Access your own VM](#access-your-own-vm)
    - [Remote Development](#remote-development)
    - [VM Contents](#vm-contents)
  - [Exercises](#exercises)
    - [Week 1-2: Introduction to P4 (21.09.2021 & 28.09.2021)](#week-1-2-introduction-to-p4-21092021--28092021)
    - [Week 3: Load balancing (05.10.2021)](#week-3-load-balancing-ecmp-and-flowlet-switching-05102021)
    - [Week 4: Probabilistic Data Structures  (12.10.2021)](#week-4-probabilistic-data-structures-12102021)
    - [Week 5: MPLS (19.10.2021)](#week-5-mpls-19102021)
    - [Week 6: RSVP (26.10.2021)](#week-6-rsvp-26102021)
    - [Week 7: Fast Reroute (2.11.2021)](#week-7-fast-reroute-02112021)
  - [Any questions?](#any-questions)

<!-- /TOC -->

## How to start?

To make your life easier, we provide every one of you with access to one VM where all the necessary tools and software are pre-installed.

### Access your own VM

To access your VM, you will use SSH. SSH is a UNIX-based command-line interface and protocol for securely getting access
to a remote computer. System administrators widely use it to control network devices
and servers remotely. An SSH client is available by default on any Linux and MAC installation
through the Terminal application. For Windows 10 users, there is SSH functionality available in the Command Prompt. For other Windows users, a good and free SSH client is [PuTTY](https://www.chiark.greenend.org.uk/~sgtatham/putty/).
Once you have installed an SSH client, use the following command to connect yourself to your
VM:

```
ssh -p X p4@orval.ethz.ch
```

Where X = 2000 + your student number for this lecture that we have sent you by email.
For instance, if you are Student-7, use the following command:

```
ssh -p 2007 p4@orval.ethz.ch
```

If you cannot connect to your VM,
please report it immediately during the exercise session.

**Optional:**
If you want to simplify the access to your VM, you can use SSH key authentication, but **do not change your
password**. If you want to download an entire directory (e.g., the configs directory) from your
VM to the current directory of your own machine, you can use scp:

```
scp -r -P X p4@orval.ethz.ch:~/path to the directory .
```

Where X = 2000 + your student number. On Windows, you can use WinSCP7 to do that. Note the
dot at the end of the command and the capitalized P.

### Remote Development

We need to be able to open and edit remote files in our local code editor to have a smooth development cycle. This way, we can work with our code locally and execute it remotely without any friction. Below, we explain how to achieve this for Visual Studio Code as an example:

1) Download Visual Studio Code.
2) Access VS Code, in the left-side dock enter `Extensions` menu.
3) Install `Remote - SSH` extension.
4) In the pop-up prompt: enter your SSH credentials as you did for the VM access.
5) Your "Remote Directory" should appear in the Explorer.
6) [Optional] Go to Extensions menu again, and install `P4 Language Extension` in your remote machine for highlights and syntax check.

For VS Code, you can find further information [here](https://code.visualstudio.com/docs/remote/ssh).
Many other text editors provide similar functionality. For example, Atom has a [remote-synch](https://atom.io/packages/remote-sync) package to upload and download files directly from inside Atom.

If you are already familiar with remote development, feel free to continue with your favorite code editor/setup.


<!-- #### VM Credentials

During the lecture, we will have two types of exercises. First, we will have p4-based exercises. Then, we will have exercises based on the mini-Internet.
We will use two different users for the two types of exercises. For the p4-based exercises please use the login `p4`, and for the mini-Internet-based exercises please use the login `mini_internet`.
We have sent you your password by email. It is the same for both logins. If you have not received your password please let us know immediately. -->

### VM Contents

The VM is based on a Ubuntu 18.04.6 LTS, and after building, it contains:

* The suite of P4 Tools ([p4lang](https://github.com/p4lang/), [p4utils](https://github.com/nsg-ethz/p4-utils), etc)
* [Wireshark](https://www.wireshark.org/)
* [Mininet](http://mininet.org/) network emulator

## Exercises

In this section, we provide links to the weekly exercises.

To get the exercises ready in your VM, clone this repository in the `p4` user home directory, as illustrated below:

```
cd /home/p4/
git clone https://gitlab.ethz.ch/nsg/public/adv-net-2021
```

Update the local repository to get new tasks and solutions.
Remember to pull this repository before every exercise session:

```
cd /home/p4/adv-net-2021
git pull https://gitlab.ethz.ch/nsg/public/adv-net-2021
```

### Week 1-2: Introduction to P4 (21.09.2021 & 28.09.2021)

* [Introduction to P4](./01-P4_Introduction)
* [Layer 2 Switch](./02-L2_Switching)

### Week 3: Load Balancing: ECMP and Flowlet Switching (05.10.2021)

 * [Load Balancing: ECMP & Flowlet Switching](./03-Load_Balancing)

### Week 4: Probabilistic Data Structures (12.10.2021)

 * [Probabilistic Data Structures](./04-Probabilistic_Data_Structures)

### Week 5: MPLS (19.10.2021)

 * [MPLS](./05-MPLS)

### Week 6: RSVP (26.10.2021)

 * [RSVP](./06-RSVP)

### Week 7: Fast Reroute (2.10.2021)

  * [Fast Reroute](./07-Fast-Reroute)


## Any questions?

If you have questions, you can ask us during the exercise sessions (every Tuesday at 4.15 pm) either in-person or via MS Teams in the `#Labs` channel. Please do **not** ask questions by email.
