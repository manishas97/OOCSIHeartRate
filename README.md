

# Heart Rate Module

We send heart rate data to all modules using the Pulse Sensor and Arduino UNO. Our data is personlized to modules upon request. The data we send entails the BPM of the user along with tags. Tags are words/phrases that analyse the current BPM recieved by the sensor. This is where our personalization comes into play. Depending on what module requests data, we send out tags/analysis to cater their particular needs.

## Getting Started

We have only included keys to get data for groups that have contacted us with the request to use our API. 


### Prerequisites

User must have library OOCSI downloaded. We send direct messages so please have a look at how to recieve direct messages and about keys and their assoicated value in OOCSI tutorials for more information . Below is a piece of code that maybe used to retrieve data.


```

oocsi.subscribe("HeartRateModule");
int bpm = event.getInt("BPM", 0);
String bpm_range = event.getString("BPMrange");
String mood = event.getString("mood");
```

Below is  snippet of how we send our data to OOCSI. 

####Coffee Group (Sending Messages)
```

 oocsi
  .channel("coffee_channel")
   //.data("BPMval",BPM)
       .data("range",BPMrange)
         .send();
         
```
####SmartCLock Group (Sending Messages)
```
oocsi
  .channel("SmartClock")
        .data("currentActivity", "retrieve")
          .data("returnChannel","HeartRateModule")
            .data("BPMval",BPM)
              .data("mood",mood)
            .send();
```
####X Group 



To recieve the heart rate of  user, the user must keep their finger on the heart rate sensor. 
Note : We cannot diffrentiate between the people scanning their finger since the equipment needed would be beyond the scope of this course.


### Important 

The snippet given above is not the only way to recieve data. Here is some important information :

#### Channel Name : heartRateModule
#### Sender Client : bpmSender

```
OOCSI oocsi;
 oocsi = new OOCSI(this,"manisha","oocsi.id.tue.nl");
 oocsi.subscribe("SmartClock");
 oocsi.subscribe("coffee_channel");
```

## MODULE CONCEPT
The module does not constantly sent heartbeat data. It makes more sense of data by sending useful data for different purposes. 
Following are some Input (BPM) related to some more useful ranges per topic. Also the relevance in our opinion to other groups is mapped.

### Tags

|INPUT RANGE|OUTPUT USEFUL|Group 2 Caffee|tag|Group 3 Pizza|tag|Group 5 Bodytemp|tag| Group 7 Clock|tag| Other Groups | tag|
|------| ------|------ | ------|------|------|------|------|-------|------ | ------|------|
|<0    | Dead  | Coffee would not help  | - |Pizza will maybe cheer up loved ones| - | Heartrate  |...bpm | Dead, might schedule funeral| Heartrate |...bpm |
|0-30  | Critial health issue  | Call 112 instead of coffee  |- | Call 112 instead of pizza  | - | Heartrate |...bpm | Critial health issue   | Heartrate |...bpm  |
|30-50 | Sleeping  | Wait for a while, coffee needed soon   | sleeping  |Pizza as breakfast? | sleeping  |Heartrate  |...bpm | Sleeping | sleeping  |Heartrate  |...bpm  | 
|50-80 | Sad or Inactive   | Coffee needed | inactive   | Need some pizza to cheer you up?   | sad   |Heartrate   |...bpm | Passive  | passive   |  Heartrate |...bpm |
|80-100| Passive  | Coffee needed  | neutral |  Pizza time? | mad |Heartrate |...bpm | No Activity | no activity |Heartrate  |...bpm |          
|>100  | Physically active | Might skip that coffee | active   |Jeej pizzaparty  | happy |Heartrate |...bpm | Activity | activity|Heartrate |...bpm   |


# DBSU10
Technologies for Connectivity 
Eindhoven University of Technology [TU/e]

## Group 1 - BPM HEARTRATE MODULE
### Contributions
### Daan Heijsters (https://github.com/daanheijsters), Manisha Sethia (https://github.com/manishas97), Stijn van Geffen (https://github.com/StijnvGeffen), Pleun Heeres (https://github.com/PJHeeres)
This repository is meant for collaborators that want to use a heartbeat sensing module for connected products.





