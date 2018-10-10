# AssetTracker iOS


The application is using webhooks to store the particle publish events to firebase. This way the app will not need to be open to receve/store the incoming data. 

## Getting Started

### Prerequisites

You will need the ```GoogleService-Info.plist ``` to run the application. In addition, you also need to add a webhook to the 
particle console. 

But first go to to firebase.google.com and create a new iOS project. Follow the instructions till you get the ```GoogleService-Info.plist ```
drag and drop it into you project. 


### Note 
A better more well documented way to add firebase to your project can be found [here](https://github.com/rickkas7/firebase_tutorial),  
but keep in mind you will need to use the following json block in your webhook for the app to function. 
***

Create a new text document with the following json. You will need to change the **url** field and the **auth** field to the ones that correspond to you firebase project. 

```
{
    "event": "test1data",
    "url": "https://FakeURl.firebaseio.com/test1data/data.json",
    "requestType": "POST",
    "query": {
    	"auth":"vuwiefbwiufbwiuefbuw2F2HRPUBt0FOyY"
    },
    "json": {
      "G": "{{G}}",
      "B": "{{B}}",
      "t": "{{PARTICLE_PUBLISHED_AT}}"
    },
    "mydevices": true,
    "noDefaults": true
}

```
You can then create the webhook using the Particle CLI and a command like:

``` particle webhook create hook.json ```

keep in mind the file name needs to be hook.json and it has to be in the same dic where you are calling the command from. 


## The Electron code. 
It's litrally the same as the GPS_Features example, But with a custom publish for the **coordinates** and **battry percent** 
You can find the gps-features src in the main dic of this repo.

```
char buf[42];
snprintf(buf, sizeof(buf), "{\"G\":\"%f,%f\",\"B\":\"%.2f\"}",t.readLatDeg(),t.readLonDeg(), fuel.getSoC());
Serial.printlnf("publishing %s", buf);
Particle.publish("G", buf, PRIVATE);

```
## Flash the Electron

If you want to try it out you can just flash the Electron with the firmware.bin file locaded in the gps-features folder.

``` particle flash --serial fullpath_of_bin. ```

## Built With

* [Firebase](http://firebase.google.com) - The backend
* [JLTGradientPathRenderer](https://github.com/joeltrew/JLTGradientPathRenderer) Gradient path. It's nice but not what I wanted, will replace in the fureture 
* [HalfModalPresentationController](https://github.com/martinnormark/HalfModalPresentationController) HalfViewController. Not perfect but it works for now

## Authors

* **Jean-Pierre Figaredo** - *Initial work*

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments

