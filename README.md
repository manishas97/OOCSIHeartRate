

# Heart Rate Module

We send heart rate data to all modules using the Pulse Sensor and Arduino UNO. Our data is personlized to modules upon request. The data we send entails the BPM of the user along with tags. Tags are words/phrases that analyse the current BPM recieved by the sensor. This is where our personalization comes into play. Depending on what module requests data, we send out tags/analysis to cater their particular needs.

## Getting Started

We have only included keys to get data for groups that have contacted us with the request to use our API. 


### Prerequisites

User must have library OOCSI downloaded. We send direct messages so please have a look at how to recieve direct messages and about keys and their assoicated value in OOCSI tutorials for more information . Below is a piece of code that maybe used to retrieve data.


```
int port;
OOCSIClient bpmReciever = new OOCSIClient("bpmReciever");

bpmReciever.connect("ws://oocsi.id.tue.nl/", port);
bpmReciever.subscribe("heartRateModule", new EventHandler(){
        public void receive(OOCSIEvent event) {
            //get labeledBPM with key BPMval
                  //if(beat==false) {
                  //System.out.print("No heart beat");
                  //}   
                  System.out.println(event.getString("BPMval",labeledBPM));
      
                  //Please only use line that relates to your group
                      System.out.println(event.getString("pizzaTags",pizza));
                     //System.out.println(event.getString("caffeeTags","caffee"));
                     //System.out.println(event.getString("clockTags","clock"));
   }
});

```

Below is  snippet of how we send our data to OOCSI. 

```

//....................SEND TO OOCSI.........................................//
//.............USE RELEVANT KEY FOR YOUR MODULE.............................//

void draw() {
  new OOCSIMessage(bpmSender,"heartRateModule")
  //We send data through channel heartRateModule via client bpmSender
  // data sent is BPM values(recommened for each group)
  .data("BPMval",labeledBPM)
    //data sent is tags for pizza group
      .data("pizzaTags",pizza)
      //data sent is tags for caffee group
       .data("caffeeTags",caffee)
       //data sent is tags for clock group
         .data("clockTags",clock)
         //send this data via OOCSI
           .send();  
  
}

```


To recieve the heart rate of  user, the user must keep their finger on the heart rate sensor. 
Note : We cannot diffrentiate between the people scanning their finger since the equipment needed would be beyond the scope of this course.


### Important 

The snippet given above is not the only way to recieve data. Here is some important information :

#### Channel Name : heartRateModule
#### Sender Client : bpmSender

```
OOCSI oocsi;
OOCSIClient bpmSender = new OOCSIClient("bpmSender");

//....................OOCSI SENDER CONNECTION...................................//
bpmSender.connect("ws://oocsi.id.tue.nl/",4444);
 // connect to OOCSI server 
 // with "heartRate" as my channel others can send data to 
   oocsi = new OOCSI(this,"heartRateModule","ws://oocsi.id.tue.nl/");
```


### Tags
To find out what tags your group will be recieveing, please check our poster.



### Contributions
Manisha, Stijn, Pleun, Daan - Technology for Connectivites (Group 1)




