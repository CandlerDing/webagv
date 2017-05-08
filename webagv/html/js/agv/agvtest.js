paper.install(window);
 
var scaleFactor = 0.05;

function zoom(factor) {
    scaleFactor = scaleFactor*factor;
    paper.project.activeLayer.scale(factor);
};

var rfids = '' ;
function submitRFIDS(){
    parent.setSelected(rfids);
    return rfids;
}

function clearSelectedRFIDS(){
      rfids ='';
}

var xmlString = '    <agvitems>\
      <Path Name="" ID="3a4e3d91-ac56-4faa-9ecd-9ed2525266ff" RFID1ID="a480a1ac-68ef-43a9-bafe-431400c2a9fc" RFID2ID="" Weigh="0.000" Length="9.000" TrackType="0" Direction="0" PathType="0">\
        <Points>-6.000 1.000 -2.000 1.000 </Points>\
      </Path>\
      <Path Name="" ID="cb920a65-f4fc-4481-9155-7f5d1e817ac6" RFID1ID="a480a1ac-68ef-43a9-bafe-431400c2a9fc" RFID2ID="74bef7f0-e60f-4941-9ece-e91edf8385cc" Weigh="0.000" Length="5.000" TrackType="0" Direction="1" PathType="0">\
        <Points>-6.000 1.000 -6.000 5.000 </Points>\
      </Path>\
      <Path Name="" ID="03d7ff8f-09b7-42e1-a6e3-318f683edddd" RFID1ID="435118a7-456c-411c-9ecb-15c1c1080335" RFID2ID="a480a1ac-68ef-43a9-bafe-431400c2a9fc" Weigh="0.000" Length="8.000" TrackType="0" Direction="1" PathType="0">\
        <Points>-6.000 -5.000 -6.000 1.000 </Points>\
      </Path>\
      <Path Name="" ID="3b2ebe84-95cd-4546-9420-182f04452850" RFID1ID="86ac592e-d7b2-447a-b4dd-a78f5004fa26" RFID2ID="10f5403b-ddb7-48d4-8ab0-5c856d605705" Weigh="0.000" Length="5.000" TrackType="0" Direction="1" PathType="0">\
        <Points>-10.000 5.000 -10.000 1.000 </Points>\
      </Path>\
      <Path Name="" ID="cbda7858-1e6d-43d4-97f3-2097776954ac" RFID1ID="10f5403b-ddb7-48d4-8ab0-5c856d605705" RFID2ID="ba0a45cd-6637-4bec-a604-ac86f0e29a46" Weigh="0.000" Length="8.000" TrackType="0" Direction="1" PathType="0">\
        <Points>-10.000 1.000 -10.000 -5.000 </Points>\
      </Path>\
      <Path Name="" ID="b8362db9-21ae-4c73-af06-556a937ba136" RFID1ID="bc558df1-c2f1-4503-8bc4-5bda538e8323" RFID2ID="" Weigh="0.000" Length="8.000" TrackType="0" Direction="1" PathType="0">\
        <Points>8.000 1.000 8.000 -3.000 </Points>\
      </Path>\
      <Path Name="" ID="32126943-953b-465d-b7a8-2ffe799e7ade" RFID1ID="589fb3d9-bd3d-47fd-8ba1-a61186ee333c" RFID2ID="bc558df1-c2f1-4503-8bc4-5bda538e8323" Weigh="0.000" Length="8.000" TrackType="0" Direction="1" PathType="0">\
        <Points>8.000 5.000 8.000 1.000 </Points>\
      </Path>\
      <Path Name="" ID="02bd2465-c5b4-4fd0-82fb-fe59c5cddcfc" RFID1ID="57884aa9-d69b-4922-ac32-7395afff7526" RFID2ID="afd2f919-a9fb-4762-bdc1-964ea7f26f0e" Weigh="0.000" Length="8.000" TrackType="0" Direction="1" PathType="0">\
        <Points>13.000 -3.000 13.000 1.000 </Points>\
      </Path>\
      <Path Name="" ID="656fc90a-a596-4538-8403-d2c04d70c1b2" RFID1ID="afd2f919-a9fb-4762-bdc1-964ea7f26f0e" RFID2ID="5d039645-c4bb-4738-8d16-72d9bb189e1a" Weigh="0.000" Length="8.000" TrackType="0" Direction="1" PathType="0">\
        <Points>13.000 1.000 13.000 5.000 </Points>\
      </Path>\
      <Path Name="" ID="fdeece6d-1111-4e09-b630-2720d54ae794" RFID1ID="5d039645-c4bb-4738-8d16-72d9bb189e1a" RFID2ID="887b720d-e06b-4f57-ae42-713129df716d" Weigh="0.000" Length="5.000" TrackType="2" Direction="1" PathType="0">\
        <Points>13.000 5.000 12.321 6.374 11.000 7.000 </Points>\
      </Path>\
      <Path Name="" ID="a26762f1-9bb2-41c7-8626-5cd81bd160d0" RFID1ID="887b720d-e06b-4f57-ae42-713129df716d" RFID2ID="589fb3d9-bd3d-47fd-8ba1-a61186ee333c" Weigh="0.000" Length="5.000" TrackType="2" Direction="1" PathType="0">\
        <Points>11.000 7.000 8.309 5.810 8.000 5.000 </Points>\
      </Path>\
      <Path Name="" ID="6b4e3952-b8c6-4b1e-ab2c-ab6e4828b663" RFID1ID="" RFID2ID="" Weigh="0.000" Length="5.000" TrackType="2" Direction="1" PathType="0">\
        <Points>8.000 -3.000 9.706 -5.038 10.000 -5.000 </Points>\
      </Path>\
      <Path Name="" ID="1abd3ed8-3c3d-4e55-9025-27d87a5c21d3" RFID1ID="" RFID2ID="57884aa9-d69b-4922-ac32-7395afff7526" Weigh="0.000" Length="5.000" TrackType="2" Direction="1" PathType="0">\
        <Points>10.000 -5.000 12.737 -4.147 13.000 -3.000 </Points>\
      </Path>\
      <Path Name="" ID="2e087d63-0e50-49e5-b205-e36828c4f42e" RFID1ID="74bef7f0-e60f-4941-9ece-e91edf8385cc" RFID2ID="86ac592e-d7b2-447a-b4dd-a78f5004fa26" Weigh="0.000" Length="5.000" TrackType="2" Direction="1" PathType="0">\
        <Points>-6.000 5.000 -8.726 6.595 -10.000 5.000 </Points>\
      </Path>\
      <Path Name="A" ID="033f928b-bb13-4381-b1d4-a88ab365124c" RFID1ID="ba0a45cd-6637-4bec-a604-ac86f0e29a46" RFID2ID="435118a7-456c-411c-9ecb-15c1c1080335" Weigh="0.000" Length="8.000" TrackType="2" Direction="1" PathType="0">\
        <Points>-10.000 -5.000 -7.876 -6.361 -6.000 -5.000 </Points>\
      </Path>\
      <RFID  Name="" ID="74bef7f0-e60f-4941-9ece-e91edf8385cc" RfidType="0" Position="-6.000 5.000" />\
      <RFID Name="" ID="86ac592e-d7b2-447a-b4dd-a78f5004fa26" RfidType="0" Position="-10.000 5.000" />\
      <RFID Name="" ID="10f5403b-ddb7-48d4-8ab0-5c856d605705" RfidType="0" Position="-10.000 1.000" />\
      <RFID Name="" ID="a480a1ac-68ef-43a9-bafe-431400c2a9fc" RfidType="0" Position="-6.000 1.000" />\
      <RFID Name="" ID="435118a7-456c-411c-9ecb-15c1c1080335" RfidType="0" Position="-6.000 -5.000" />\
      <RFID Name="" ID="ba0a45cd-6637-4bec-a604-ac86f0e29a46" RfidType="0" Position="-10.000 -5.000" />\
      <RFID Name="" ID="bc558df1-c2f1-4503-8bc4-5bda538e8323" RfidType="0" Position="8.000 1.000" />\
      <RFID Name="" ID="887b720d-e06b-4f57-ae42-713129df716d" RfidType="0" Position="11.000 7.000" />\
      <RFID Name="" ID="589fb3d9-bd3d-47fd-8ba1-a61186ee333c" RfidType="0" Position="8.000 5.000" />\
      <RFID Name="" ID="5d039645-c4bb-4738-8d16-72d9bb189e1a" RfidType="0" Position="13.000 5.000" />\
      <RFID Name="" ID="afd2f919-a9fb-4762-bdc1-964ea7f26f0e" RfidType="0" Position="13.000 1.000" />\
      <RFID Name="" ID="57884aa9-d69b-4922-ac32-7395afff7526" RfidType="0" Position="13.000 -3.000" />\
      <Path Name="" ID="2c625296-8f8d-48ac-9cb7-8eff0d26e3de" RFID1ID="" RFID2ID="" Weigh="0.000" Length="9.000" TrackType="0" Direction="0" PathType="0">\
        <Points>-2.000 1.000 4.000 1.000 </Points>\
      </Path>\
      <Path Name="" ID="ddf99511-0c71-48cd-90f9-4cb87b82c0b7" RFID1ID="" RFID2ID="bc558df1-c2f1-4503-8bc4-5bda538e8323" Weigh="0.000" Length="9.000" TrackType="0" Direction="1" PathType="0">\
        <Points>4.000 1.000 8.000 1.000 </Points>\
      </Path>\
      <Path Name="" ID="0de67693-9034-4716-8803-1c489687d3dc" RFID1ID="" RFID2ID="" Weigh="0.000" Length="3.000" TrackType="1" Direction="1" PathType="1">\
        <Points>4.000 1.000 2.305 1.687 2.000 2.000 </Points>\
      </Path>\
      <Path Name="" ID="304b8842-c2ac-4632-bacd-d097ea5fc3bb" RFID1ID="" RFID2ID="" Weigh="0.000" Length="3.000" TrackType="2" Direction="1" PathType="1">\
        <Points>2.000 2.000 0.474 2.402 0.000 2.000 </Points>\
      </Path>\
      <Path Name="" ID="8cb9ebd3-e045-4456-9bb4-3450b52bb35f" RFID1ID="" RFID2ID="" Weigh="0.000" Length="3.000" TrackType="1" Direction="1" PathType="1">\
        <Points>0.000 2.000 -0.888 1.174 -2.000 1.000 </Points>\
      </Path>\
      <Path Name="" ID="6388c7ef-af0c-4cf8-8707-bcc3edd91c37" RFID1ID="" RFID2ID="" Weigh="0.000" Length="3.000" TrackType="1" Direction="1" PathType="1">\
        <Points>-2.000 1.000 -0.308 0.347 0.000 0.000 </Points>\
      </Path>\
      <Path Name="" ID="f6eecd94-8cd9-4899-bd1d-a6f4e6a24ecf" RFID1ID="" RFID2ID="" Weigh="0.000" Length="3.000" TrackType="2" Direction="1" PathType="1">\
        <Points>0.000 0.000 0.563 -0.948 2.000 -1.000 </Points>\
      </Path>\
      <Path Name="" ID="0153b2d4-dc74-46be-98f0-34ae2e7aa305" RFID1ID="" RFID2ID="" Weigh="0.000" Length="3.000" TrackType="1" Direction="1" PathType="1">\
        <Points>2.000 -1.000 2.684 0.258 4.000 1.000 </Points>\
      </Path>\
      <RFID Name="" ID="70fc4ce7-11bc-454f-b03e-7c9d62ae00b0" RfidType="0" Position="-2.000 1.000" />\
      <RFID Name="" ID="9b681498-a47b-4d50-924c-468951474200" RfidType="1" Position="0.000 2.000" />\
      <RFID Name="" ID="67e97c30-f022-4c72-8d68-a88ddd375522" RfidType="1" Position="0.000 0.000" />\
      <RFID Name="" ID="ac4105cf-df2f-4160-b9b3-b18a75c33ef9" RfidType="1" Position="2.000 -1.000" />\
      <RFID Name="" ID="e0fb0cfe-705d-46b3-9f7b-9427cba3f11d" RfidType="0" Position="4.000 1.000" />\
      <RFID Name="" ID="6d529ca0-c67b-48e2-88c0-73226daa7248" RfidType="1" Position="2.000 2.000" />\
    </agvitems>\
    ';

window.onload = function () {
    paper.setup('myCanvas');
    var tool = new Tool();
    var model = new AGV.Model();
    model.FromXML(xmlString);

    var hitOptions = {
        segments:true,
        stroke:true,
        fill:true,
        tolerance:5
    };

    view.onResize = function onResize(event) {

    }

    var tool = paper.tool;
    tool.minDistance = 20;
    tool.activate();

    var singleClick = false;


    tool.onMouseDown = function (event) {
        singleClick = true;

        priPnt = event.point;
    }

    var priPnt = null;
 
    tool.onMouseDrag = function onMouseDrag(event) {
        singleClick = false;

        var curPnt = event.point;
        var deltaPnt = curPnt.subtract(priPnt).multiply(new paper.Point(scaleFactor,scaleFactor));

        paper.project.activeLayer.translate(deltaPnt);

    }

    tool.onMouseMove = function onMouseMove(event) {
    paper.project.activeLayer.selected = false;
     var hitResult = project.hitTest(event.point, hitOptions);
        if (!hitResult) {
            return;
        }
        if (hitResult) {
        hitResult.item.selected = true;  
        }
    }

    tool.onMouseUp = function onMouseUp(event) {
        if (!singleClick) {
            return;
        }
        var hitResult = project.hitTest(event.point, hitOptions);
        if (!hitResult) {
            return;
        }

        if (hitResult) {
            var path = hitResult.item;
            if (!path.data.selected) {
                path.data.SetSelected(true);
            } else {
                path.data.SetSelected(false);
            }

            var type = path.data.type;
            if(type == 'Path'){
                var agvPath = path.data;
   
            }else if(type == 'RFID'){
                var agvRfid = path.data;

                rfids += agvRfid.id +';;';
 
                console.log(rfids);
            }
        }
    }

}
