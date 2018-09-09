---
layout: blog-post
title: "BOINC LCS 3.0 Beta"
author: "Mark Honeychurch"
date: 2008-03-13
---

I was testing out the [BOINC LCS 3.0 Beta](http://www.conmunix.net/offene-projekte/boinc-lcs/) ([demo here](http://www.conmunix.net/.demo/boinc_lcs/)), as I currently have 5 machines working on the [SETI@HOME project](http://setiathome.berkeley.edu/) and thought it might be nice to be able to put online a quick overview of what the machines in my house are working on at any given moment. I found that with my multi-processor machines (one of which is a dual Xeon proc with hyperthreading, which equates to 4 processors as far as [BOINC](http://boinc.berkeley.edu/) is concerned!) the program was only showing the first of the workunits that the machine was working on. After a quick delve into the code, I found that the problem was that once the correct info had been read from client_state.xml, the array that was produced wasn't being read properly. The offending code was:

``` php
if(is_object($elements->active_task_set)) {
     foreach($elements->active_task_set as $task) {
>

Project URL

    [active_task->project_master_url; ?>](http://www.blogger.com/%3C?php%20echo%20$task-%3Eactive_task-%3Eproject_master_url;%20?%3E)



    Result Name

    active_task->result_name; ?>



    Work done

    active_task->fraction_done,100,2); ?> %




    <div class="fractioncontainer"><div class="fractiondone" style="width: <?php echo bcmul($task->active_task->fraction_done,100,0);"></div></div>


    Computing time

    active_task->current_cpu_time,0,'','')); echo $time["hours"]<1 data-blogger-escaped-:="" data-blogger-escaped-echo="" data-blogger-escaped-hours="" data-blogger-escaped-minutes="" data-blogger-escaped-seconds="" data-blogger-escaped-time=""><!--1-->


     }
    }
?></code>
The code references foreach($elements->active_task_set as $task), where $elements->active_task_set is an array element containing a sub-array of active tasks. Instead, we need to change this to reference the sub-array elements, as in foreach($elements->active_task_set->active_task as $task). This way, the foreach statement reads through each sub-array, which contains the info for a single task. Once this has been changed, each subsequent reference to $task->active_task needs to be changed to just $task. Change this code to the following and it should work:

<code>
    if(is_object($elements->active_task_set)) {
     foreach($elements->active_task_set->active_task as $task) {
?>

    </code>
<code>Project URL</code>
<code>
    [project_master_url; ?>](http://www.blogger.com/%3C?php%20echo%20$task-%3Eproject_master_url;%20?%3E)



    Result Name

    result_name; ?>



    Work done

    fraction_done,100,2); ?> %




    <div class="fractioncontainer"><div class="fractiondone" style="width: <?php echo bcmul($task->fraction_done,100,0);"></div></div>


    Computing time

    current_cpu_time,0,'','')); echo $time["hours"]<1 data-blogger-escaped-:="" data-blogger-escaped-echo="" data-blogger-escaped-hours="" data-blogger-escaped-minutes="" data-blogger-escaped-seconds="" data-blogger-escaped-time=""><!--1-->


     }
    }
?></code>
This bugfix has been posted to the developer's site, but I've heard nothing back yet. I guess the developer probably just has a single processor machine and as such didn't spot this.

In case anyone's interested in how my BOINC number crunching has been going recently, you can have a look at [my BOINC Stats page](http://www.boincstats.com/stats/boinc_user_graph.php?pr=bo&amp;id=8aa97f9df3024245aa460178ddd7db91). I also plan to add a page to this site soon which will grab these graphs and other info (such as that from BOINC LCS) and display them in a nice overview of one of my geek projects!



The author of BOINC LCS, Wilhelm, has now emailed me to confirm that he has received my bugfix and will be incorporating it in his software.

