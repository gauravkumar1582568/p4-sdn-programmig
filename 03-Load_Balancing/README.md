# Load Balancing with P4

In this week exercises you will be implementing two different layer-4 load
balancers. First of all, you will start using layer-3 forwarding table and on
top of that, you will make sure that traffic gets load balanced across equal
cost paths.

[In the first exercise](./01-ECMP), you will implement a l3 switch with ECMP
capabilities. After, [in the second part of the
exercise](./02-Flowlet_Switching), you will extend your code and make the load
balancing a bit mor dynamic, by changing the load balancing decision for
different flowlets within a same TCP flow.

Finally, [we propose you an optional exercise](./03-Dynamic_Routing), in which
you will learn how to dynamically populate all the routing tables and
load-balancing tables automatically using a P4 controller. In this exercise you
will also learn how to read topology information so that you can populate switch
tables for any topology!