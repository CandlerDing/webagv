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

var xmlString = '<agvitems>\
<PathNode Name="C" ID="a7664d96-fcfa-4b24-8551-c4e5604f00b7" PathNodeType="0" ProtoID="0" Position="-12.000 3.000" />\
<PathNode Name="D" ID="6c44a292-2704-41dd-8f21-456f5b58187e" PathNodeType="0" ProtoID="0" Position="-10.000 3.000" />\
<PathNode Name="E" ID="038e37bf-77b9-435a-82c7-54014a0196ac" PathNodeType="0" ProtoID="0" Position="-6.000 3.000" />\
<PathNode Name="F" ID="8f343508-5037-46f8-8642-51a360b15d68" PathNodeType="0" ProtoID="0" Position="-5.000 2.000" />\
<PathNode Name="G" ID="06961c3f-e972-4ef8-8176-3ec865f80987" PathNodeType="0" ProtoID="0" Position="-3.000 1.000" />\
<PathNode Name="H" ID="09859102-b881-4457-a7d0-9655c0bf75fe" PathNodeType="0" ProtoID="0" Position="-1.000 3.000" />\
<PathNode Name="I" ID="1bcbb3b8-b057-4aab-b21b-a4f9be14ea5b" PathNodeType="0" ProtoID="0" Position="2.000 5.000" />\
<PathNode Name="J" ID="1ad0c983-55ed-4245-a795-990c62d30100" PathNodeType="0" ProtoID="0" Position="4.000 3.000" />\
<PathNode Name="K" ID="904b4395-a59f-4143-aed5-7e1f016c6661" PathNodeType="0" ProtoID="0" Position="4.000 0.000" />\
<PathNode Name="L" ID="8fd55fbe-df86-45dd-9197-34be8307aed2" PathNodeType="0" ProtoID="0" Position="3.000 -1.000" />\
<PathNode Name="M" ID="2b31f071-dc71-4d93-8c3c-b2911ca7e801" PathNodeType="0" ProtoID="0" Position="-2.000 -1.000" />\
<PathNode Name="N" ID="018d2539-f45d-4816-8284-03ab6345e0cd" PathNodeType="0" ProtoID="0" Position="-2.990 -0.396" />\
<PathNode Name="O" ID="cced0c0e-c850-4504-a7fd-84d80d902eb2" PathNodeType="0" ProtoID="0" Position="-3.998 0.223" />\
<PathNode Name="P" ID="7a7d9690-33f4-49b9-8279-6801fd77bfd6" PathNodeType="0" ProtoID="0" Position="-5.645 0.238" />\
<PathNode Name="Q" ID="1da83ec8-7771-4507-966d-b672f4f59b3c" PathNodeType="0" ProtoID="0" Position="-6.988 -0.469" />\
<PathNode Name="R" ID="9d81b5d0-13ac-4b96-a379-9d6afe4d97d5" PathNodeType="0" ProtoID="0" Position="-8.000 -1.000" />\
<PathNode Name="S" ID="b5f38612-a8a1-4e82-8df2-86f8254b966c" PathNodeType="0" ProtoID="0" Position="-10.000 -1.000" />\
<PathNode Name="U" ID="e4036451-5291-42e8-9875-df5207b2a681" PathNodeType="0" ProtoID="0" Position="-11.000 0.000" />\
<PathNode Name="V" ID="aa7fd80d-475a-4f9e-84a1-59d705c787f0" PathNodeType="0" ProtoID="0" Position="-11.000 2.000" />\
<PathNode Name="B" ID="b11780e8-8036-49a9-91ff-e000196abdf7" PathNodeType="0" ProtoID="0" Position="-13.000 2.000" />\
<PathNode Name="A" ID="4e813492-9609-42c1-a7ed-85e530a700cd" PathNodeType="0" ProtoID="0" Position="-13.000 0.000" />\
<PathNode Name="T" ID="1c9962ec-fc9d-4708-bb1b-23514f98a10c" PathNodeType="0" ProtoID="0" Position="-12.000 -1.000" />\
<Path Name="CD" ID="4e9a3525-90ee-4c47-abf7-1a31863c9abf" StartPathNodeId="a7664d96-fcfa-4b24-8551-c4e5604f00b7" EndPathNodeId="6c44a292-2704-41dd-8f21-456f5b58187e" Weigh="1.000" Length="1.000" TrackType="0" Direction="1" PathType="0" ForwardStartID="02 30 30 30 30 30 30 30 30 30 33 0D 0A 03" ForwardEndID="02 30 30 30 30 30 30 30 30 30 34 0D 0A 03" BackwardEndID="" BackwardStartID="" AreaCode="S0_3">\
  <Points>-12.000 3.000 -10.000 3.000 </Points>\
</Path>\
<Path Name="DE" ID="457e31d1-6270-4185-a2a1-c41b0a6b5c5e" StartPathNodeId="6c44a292-2704-41dd-8f21-456f5b58187e" EndPathNodeId="038e37bf-77b9-435a-82c7-54014a0196ac" Weigh="1.000" Length="1.000" TrackType="0" Direction="1" PathType="0" ForwardStartID="02 30 30 30 30 30 30 30 30 30 34 0D 0A 03" ForwardEndID="02 30 30 30 30 30 30 30 30 30 35 0D 0A 03" BackwardEndID="" BackwardStartID="" AreaCode="S0_4">\
  <Points>-10.000 3.000 -6.000 3.000 </Points>\
</Path>\
<Path Name="LM" ID="49b140ee-714e-4ce3-862e-720049056c3b" StartPathNodeId="8fd55fbe-df86-45dd-9197-34be8307aed2" EndPathNodeId="2b31f071-dc71-4d93-8c3c-b2911ca7e801" Weigh="1.000" Length="1.000" TrackType="0" Direction="1" PathType="0" ForwardStartID="02 30 34 31 35 41 41 45 33 37 34 0D 0A 03" ForwardEndID="02 30 34 31 35 41 41 45 33 43 43 0D 0A 03" BackwardEndID="" BackwardStartID="" AreaCode="S0_12">\
  <Points>3.000 -1.000 -2.000 -1.000 </Points>\
</Path>\
<Path Name="RS" ID="0a015d22-dba3-4742-9ae8-6623c63a15d9" StartPathNodeId="9d81b5d0-13ac-4b96-a379-9d6afe4d97d5" EndPathNodeId="b5f38612-a8a1-4e82-8df2-86f8254b966c" Weigh="1.000" Length="1.000" TrackType="0" Direction="1" PathType="0" ForwardStartID="02 30 34 31 35 41 41 45 33 33 36 0D 0A 03" ForwardEndID="02 30 34 31 35 41 41 45 33 41 31 0D 0A 03" BackwardEndID="" BackwardStartID="" AreaCode="S0_14">\
  <Points>-8.000 -1.000 -10.000 -1.000 </Points>\
</Path>\
<Path Name="ST" ID="ccd5a39a-f5cd-4a4d-b535-54abd5e70700" StartPathNodeId="b5f38612-a8a1-4e82-8df2-86f8254b966c" EndPathNodeId="1c9962ec-fc9d-4708-bb1b-23514f98a10c" Weigh="1.000" Length="1.000" TrackType="0" Direction="1" PathType="0" ForwardStartID="02 30 34 31 35 41 41 45 33 41 31 0D 0A 03" ForwardEndID="02 30 30 30 30 30 30 30 30 31 30 0D 0A 03" BackwardEndID="" BackwardStartID="" AreaCode="S0_15">\
  <Points>-10.000 -1.000 -12.000 -1.000 </Points>\
</Path>\
<AGVText Name="1" ID="c9198797-f33a-4581-b54a-397dd4fcb024" Position="-13.307 0.981" Angle="0.000" FontSize="12.000" />\
<Path Name="Path" ID="aeea0356-e771-4874-acc4-5ba6554783a4" StartPathNodeId="2b31f071-dc71-4d93-8c3c-b2911ca7e801" EndPathNodeId="9d81b5d0-13ac-4b96-a379-9d6afe4d97d5" Weigh="1.000" Length="1.000" TrackType="0" Direction="1" PathType="0" ForwardStartID="02 30 34 31 35 41 41 45 33 43 43 0D 0A 03" ForwardEndID="02 30 34 31 35 41 41 45 33 33 36 0D 0A 03" BackwardEndID="" BackwardStartID="" AreaCode="S0_13">\
  <Points>-2.000 -1.000 -8.000 -1.000 </Points>\
</Path>\
<AGVText Name="2" ID="3073d13f-aee0-4717-a768-c296ac1f6aaf" Position="-12.860 2.835" Angle="0.000" FontSize="12.000" />\
<AGVText Name="3" ID="4a1b0895-22e3-4851-90a7-0eac008a3046" Position="-11.096 3.192" Angle="0.000" FontSize="12.000" />\
<AGVText Name="4" ID="beb20bed-b647-4397-b5b8-89f3eefc157e" Position="-7.725 3.259" Angle="0.000" FontSize="12.000" />\
<AGVText Name="5" ID="47063002-d8f9-48e4-8ac0-9f48631bb9ad" Position="-5.157 2.969" Angle="0.000" FontSize="12.000" />\
<AGVText Name="6" ID="9610a11a-0553-46b4-a94e-2bf400867709" Position="-3.884 1.517" Angle="0.000" FontSize="12.000" />\
<AGVText Name="7" ID="7aacba7f-d1cc-4074-8929-17b02e05a474" Position="-2.276 2.165" Angle="0.000" FontSize="12.000" />\
<AGVText Name="8" ID="75be0d0b-714c-47ec-a775-f5d524781a29" Position="-0.468 4.286" Angle="0.000" FontSize="12.000" />\
<AGVText Name="9" ID="24b2126b-db9d-4309-8af8-d777702c2218" Position="3.686 4.264" Angle="0.000" FontSize="12.000" />\
<AGVText Name="10" ID="44eaca68-e16e-4330-865a-efc9fbf2f0b7" Position="4.422 1.339" Angle="0.000" FontSize="12.000" />\
<AGVText Name="11" ID="00fc5293-ff18-4313-a9c9-d33c3165cc29" Position="4.000 -1.000" Angle="0.000" FontSize="12.000" />\
<AGVText Name="12" ID="6356fcd2-af0d-46ba-b2b5-1ee9152b2b19" Position="1.118 -1.274" Angle="0.000" FontSize="12.000" />\
<AGVText Name="13" ID="a0be892c-4560-4909-8d90-b685ed7f4b2c" Position="-4.397 -1.385" Angle="0.000" FontSize="12.000" />\
<AGVText Name="14" ID="8db0cda9-74f0-46e2-8d9f-49e07a1eb374" Position="-8.930 -1.363" Angle="0.000" FontSize="12.000" />\
<AGVText Name="15" ID="ce98b548-b66b-49bf-b739-e70a7a5db634" Position="-11.119 -1.385" Angle="0.000" FontSize="12.000" />\
<AGVText Name="18" ID="77091308-f7df-406e-998d-a5cad5b0118e" Position="-3.195 0.314" Angle="0.000" FontSize="12.000" />\
<AGVText Name="19" ID="b65caddb-e362-4d3a-ae1f-78e86434b636" Position="-4.851 0.027" Angle="0.000" FontSize="12.000" />\
<AGVText Name="20" ID="51c4921b-3dc1-4513-a7e7-34047ca5a5d7" Position="-6.529 0.347" Angle="0.000" FontSize="12.000" />\
<AGVText Name="21" ID="e5a4ce4c-71d3-4168-ae17-286800a94549" Position="-7.608 -0.470" Angle="0.000" FontSize="12.000" />\
<AGVText Name="22" ID="cc882e48-d561-4d06-b2a9-c5255d5ad5fd" Position="-10.321 -0.340" Angle="0.000" FontSize="12.000" />\
<AGVText Name="16" ID="c84fc013-8e86-4def-83bc-0e4c75e3666e" Position="-12.838 -0.984" Angle="0.000" FontSize="12.000" />\
<AGVText Name="23" ID="2f880ff9-eb2b-4998-afb0-5268a4e73083" Position="-10.746 0.968" Angle="0.000" FontSize="12.000" />\
<AGVText Name="24" ID="37b70e2f-7d7a-4e3f-8605-93db64ec33d7" Position="-10.321 2.374" Angle="0.000" FontSize="12.000" />\
<AGVText Name="17" ID="ab5aaf0f-6db1-4d45-9ed7-cf451246ef2a" Position="-1.985 -0.372" Angle="0.000" FontSize="12.000" />\
<AGVText Name="B" ID="be199add-be66-4c9b-ae7e-a7e5bed8150c" Position="-13.677 1.880" Angle="0.000" FontSize="12.000" />\
<AGVText Name="C" ID="b47630d2-c049-4f0a-a248-8d129fdb46d7" Position="-11.787 3.464" Angle="0.000" FontSize="12.000" />\
<AGVText Name="D" ID="fdaf545b-441b-4bf1-8162-0ddbae88d2f2" Position="-9.709 3.413" Angle="0.000" FontSize="12.000" />\
<AGVText Name="E" ID="56192fdf-67c4-4693-a7b1-e87fe6d0f8fc" Position="-6.677 3.379" Angle="0.000" FontSize="12.000" />\
<AGVText Name="F" ID="0ac67c31-98e0-46d6-8e51-cfa5e9851809" Position="-4.616 2.527" Angle="0.000" FontSize="12.000" />\
<AGVText Name="G" ID="57311112-bd75-476d-bc0c-4eb3190239b2" Position="-2.698 0.739" Angle="0.000" FontSize="12.000" />\
<AGVText Name="H" ID="d637dc87-1494-476d-a18c-5323d2d8fd71" Position="-0.246 2.943" Angle="0.000" FontSize="12.000" />\
<AGVText Name="I" ID="456a5ee0-8e4e-4982-8c59-8a699f8c3c5e" Position="1.941 5.610" Angle="0.000" FontSize="12.000" />\
<AGVText Name="J" ID="df844633-bdf4-4546-9df2-cad9a1718948" Position="4.734 2.629" Angle="0.000" FontSize="12.000" />\
<AGVText Name="K" ID="09f6bdcf-ddcb-442f-869b-ac79053f77d0" Position="4.647 0.261" Angle="0.000" FontSize="12.000" />\
<AGVText Name="L" ID="dae57e85-f335-4862-8a03-ed0882acf7e8" Position="2.567 -0.522" Angle="0.000" FontSize="12.000" />\
<AGVText Name="M" ID="04f9eae8-baad-4aa2-ae09-f7a504ca4e5c" Position="-1.492 -0.676" Angle="0.000" FontSize="12.000" />\
<AGVText Name="N" ID="f25664c1-9a0b-4844-8afd-9394aeeca699" Position="-2.603 0.075" Angle="0.000" FontSize="12.000" />\
<AGVText Name="O" ID="09ee25d7-ebd8-403f-aedc-64e9a7a2b84a" Position="-4.119 0.505" Angle="0.000" FontSize="12.000" />\
<AGVText Name="P" ID="7cc66fe1-ab57-4b03-8be8-51164869d845" Position="-5.414 0.534" Angle="0.000" FontSize="12.000" />\
<AGVText Name="R" ID="ecc0d422-01b9-4074-b556-3caf312240e0" Position="-8.302 -1.405" Angle="0.000" FontSize="12.000" />\
<AGVText Name="S" ID="4a465b2d-ef04-4f5e-85e5-5333113e6f6f" Position="-9.788 -1.420" Angle="0.000" FontSize="12.000" />\
<AGVText Name="T" ID="b8754555-9922-4c55-aad8-04f4b20b2b17" Position="-11.823 -1.484" Angle="0.000" FontSize="12.000" />\
<AGVText Name="A" ID="9ed124f1-b0c4-4152-8bd6-6adad7361742" Position="-13.547 0.196" Angle="0.000" FontSize="12.000" />\
<AGVText Name="U" ID="0be2bf04-0478-47f7-9df9-a8a1b465becd" Position="-11.593 0.056" Angle="0.000" FontSize="12.000" />\
<AGVText Name="V" ID="6a173951-36fd-4d43-9002-e8f8b91fad1c" Position="-11.624 1.564" Angle="0.000" FontSize="12.000" />\
<AGVRFID Name="RFID" ID="174d0721-1adf-49a9-a36f-0647509b97eb" Position="-13.196 1.748" ProtoValue="" />\
<AGVRFID Name="RFID" ID="4deee01c-4427-4c4e-ae90-e671654b4bed" Position="-11.780 3.196" ProtoValue="" />\
<AGVRFID Name="RFID" ID="1015a22e-ca6d-42f2-abbf-06572a70dc24" Position="-9.702 3.079" ProtoValue="" />\
<AGVRFID Name="RFID" ID="14201d80-dc08-4cec-9552-17994a56bc06" Position="-6.657 3.154" ProtoValue="" />\
<AGVRFID Name="RFID" ID="fcdd8572-de6d-494c-9f8d-d6c67df89fe0" Position="-4.971 2.273" ProtoValue="" />\
<AGVRFID Name="RFID" ID="a3e55db7-f4d9-4c94-9f9b-da3383c25eaa" Position="-3.004 0.866" ProtoValue="" />\
<AGVRFID Name="RFID" ID="4ee0b567-3e73-4cb1-85ee-d81499a699a4" Position="-0.737 2.948" ProtoValue="" />\
<AGVRFID Name="RFID" ID="bf71d84b-5d27-44e3-bebc-5ba7014de0b6" Position="4.121 2.613" ProtoValue="" />\
<AGVRFID Name="RFID" ID="729d7ff4-e1fa-4c20-821f-09fd245adf27" Position="4.157 0.243" ProtoValue="" />\
<AGVRFID Name="RFID" ID="cced8953-a99c-4c8e-bbb5-774723ed6275" Position="2.647 -0.880" ProtoValue="" />\
<AGVRFID Name="RFID" ID="4eb497ba-eaa0-41e7-8601-b55a3fb4b836" Position="-1.492 -0.866" ProtoValue="" />\
<AGVRFID Name="RFID" ID="19354cb7-2bc7-4584-b759-7a38b7c26a07" Position="-8.328 -1.175" ProtoValue="" />\
<AGVRFID Name="RFID" ID="a32e5e96-82fc-49fd-b20f-0e468aada739" Position="-9.786 -1.162" ProtoValue="" />\
<AGVRFID Name="RFID" ID="7548e57a-ce75-413e-ab13-9a26813116f6" Position="-11.798 -1.198" ProtoValue="" />\
<AGVRFID Name="RFID" ID="6350640e-9fd9-44d7-b9bb-4747b851a8f5" Position="-13.131 0.218" ProtoValue="" />\
<AGVRFID Name="RFID" ID="6fcd34fe-b23f-464c-a3ad-a27a2dc67720" Position="-2.827 -0.303" ProtoValue="" />\
<AGVRFID Name="RFID" ID="b32fc5c1-78d9-434d-a332-602e27f8da5c" Position="1.999 5.219" ProtoValue="" />\
<AGVRFID Name="RFID" ID="24576c2f-dd0d-42fc-9325-f60c3c78ad30" Position="-4.119 0.365" ProtoValue="" />\
<AGVRFID Name="RFID" ID="f91db896-e448-4b80-a6a7-f10d1f8d165e" Position="-5.371 0.322" ProtoValue="" />\
<AGVRFID Name="RFID" ID="bc4ccd4a-5f7d-46a1-96be-991d35936443" Position="-7.155 -0.266" ProtoValue="" />\
<AGVText Name="Q" ID="f539cf77-25bd-4f49-abcd-437d18f67fda" Position="-7.334 -0.074" Angle="0.000" FontSize="12.000" />\
<AGVRFID Name="RFID" ID="3161a452-e342-4b2e-8431-5a01e6700833" Position="-11.161 0.041" ProtoValue="" />\
<AGVRFID Name="RFID" ID="0032e3b9-70f0-4e8d-9cee-96bdfe44485a" Position="-11.161 1.602" ProtoValue="" />\
<Path Name="AB" ID="a57766ef-77ef-491b-9367-59bf474a2585" StartPathNodeId="4e813492-9609-42c1-a7ed-85e530a700cd" EndPathNodeId="b11780e8-8036-49a9-91ff-e000196abdf7" Weigh="1.000" Length="1.000" TrackType="0" Direction="1" PathType="0" ForwardStartID="02 30 30 30 30 30 30 30 30 30 31 0D 0A 03" ForwardEndID="02 30 30 30 30 30 30 30 30 30 32 0D 0A 03" BackwardEndID="" BackwardStartID="" AreaCode="S0_1">\
  <Points>-13.000 0.000 -13.000 2.000 </Points>\
</Path>\
<Path Name="BC" ID="75fe9591-29f6-4d41-a8e5-038d3adeefbc" StartPathNodeId="b11780e8-8036-49a9-91ff-e000196abdf7" EndPathNodeId="a7664d96-fcfa-4b24-8551-c4e5604f00b7" Weigh="1.000" Length="1.000" TrackType="1" Direction="1" PathType="0" ForwardStartID="02 30 30 30 30 30 30 30 30 30 32 0D 0A 03" ForwardEndID="02 30 30 30 30 30 30 30 30 30 33 0D 0A 03" BackwardEndID="" BackwardStartID="" AreaCode="S0_2">\
  <Points>-13.000 2.000 -12.707 2.707 -12.000 3.000 </Points>\
</Path>\
<Path Name="EF" ID="b2b18079-40d5-4e9c-acf7-e5966548622a" StartPathNodeId="038e37bf-77b9-435a-82c7-54014a0196ac" EndPathNodeId="8f343508-5037-46f8-8642-51a360b15d68" Weigh="1.000" Length="1.000" TrackType="1" Direction="1" PathType="0" ForwardStartID="02 30 30 30 30 30 30 30 30 30 35 0D 0A 03" ForwardEndID="02 30 30 30 30 30 30 30 30 30 36 0D 0A 03" BackwardEndID="" BackwardStartID="" AreaCode="S0_5">\
  <Points>-6.000 3.000 -5.254 2.405 -5.000 2.000 </Points>\
</Path>\
<Path Name="FG" ID="b4eac27b-db74-4ed7-a88a-020a921bc6d6" StartPathNodeId="8f343508-5037-46f8-8642-51a360b15d68" EndPathNodeId="06961c3f-e972-4ef8-8176-3ec865f80987" Weigh="1.000" Length="1.000" TrackType="2" Direction="1" PathType="0" ForwardStartID="02 30 30 30 30 30 30 30 30 30 36 0D 0A 03" ForwardEndID="02 30 30 30 30 30 30 30 30 30 37 0D 0A 03" BackwardEndID="" BackwardStartID="" AreaCode="S0_6">\
  <Points>-5.000 2.000 -3.962 1.113 -3.000 1.000 </Points>\
</Path>\
<Path Name="GH" ID="011b5101-ba48-4e33-a9cd-79e1d093ee96" StartPathNodeId="06961c3f-e972-4ef8-8176-3ec865f80987" EndPathNodeId="09859102-b881-4457-a7d0-9655c0bf75fe" Weigh="1.000" Length="1.000" TrackType="2" Direction="1" PathType="0" ForwardStartID="02 30 30 30 30 30 30 30 30 30 37 0D 0A 03" ForwardEndID="02 30 30 30 30 30 30 30 30 30 38 0D 0A 03" BackwardEndID="" BackwardStartID="" AreaCode="S0_7">\
  <Points>-3.000 1.000 -1.526 1.787 -1.000 3.000 </Points>\
</Path>\
<Path Name="HI" ID="216d807b-66bf-4287-929e-40a5ffbb1b78" StartPathNodeId="09859102-b881-4457-a7d0-9655c0bf75fe" EndPathNodeId="1bcbb3b8-b057-4aab-b21b-a4f9be14ea5b" Weigh="1.000" Length="1.000" TrackType="1" Direction="1" PathType="0" ForwardStartID="02 30 30 30 30 30 30 30 30 30 38 0D 0A 03" ForwardEndID="02 30 30 30 30 30 30 30 30 30 39 0D 0A 03" BackwardEndID="" BackwardStartID="" AreaCode="S0_8">\
  <Points>-1.000 3.000 0.369 4.542 2.000 5.000 </Points>\
</Path>\
<Path Name="IJ" ID="44d12df2-0433-440d-9e51-e92d219758f6" StartPathNodeId="1bcbb3b8-b057-4aab-b21b-a4f9be14ea5b" EndPathNodeId="1ad0c983-55ed-4245-a795-990c62d30100" Weigh="1.000" Length="1.000" TrackType="1" Direction="1" PathType="0" ForwardStartID="02 30 30 30 30 30 30 30 30 30 39 0D 0A 03" ForwardEndID="02 30 34 31 35 41 41 45 31 46 38 0D 0A 03" BackwardEndID="" BackwardStartID="" AreaCode="S0_9">\
  <Points>2.000 5.000 3.722 3.943 4.000 3.000 </Points>\
</Path>\
<Path Name="JK" ID="f8e5fd6b-fa50-4f39-86f5-8aa97938db7e" StartPathNodeId="1ad0c983-55ed-4245-a795-990c62d30100" EndPathNodeId="904b4395-a59f-4143-aed5-7e1f016c6661" Weigh="1.000" Length="1.000" TrackType="0" Direction="1" PathType="0" ForwardStartID="02 30 34 31 35 41 41 45 31 46 38 0D 0A 03" ForwardEndID="02 30 34 31 35 41 41 45 32 37 46 0D 0A 03" BackwardEndID="" BackwardStartID="" AreaCode="S0_10">\
  <Points>4.000 3.000 4.000 0.000 </Points>\
</Path>\
<Path Name="KL" ID="1cfe31d6-8f80-4243-b2e6-a716524210d7" StartPathNodeId="904b4395-a59f-4143-aed5-7e1f016c6661" EndPathNodeId="8fd55fbe-df86-45dd-9197-34be8307aed2" Weigh="1.000" Length="1.000" TrackType="1" Direction="1" PathType="0" ForwardStartID="02 30 34 31 35 41 41 45 32 37 46 0D 0A 03" ForwardEndID="02 30 34 31 35 41 41 45 33 37 34 0D 0A 03" BackwardEndID="" BackwardStartID="" AreaCode="S0_11">\
  <Points>4.000 0.000 3.707 -0.707 3.000 -1.000 </Points>\
</Path>\
<Path Name="TA" ID="ba8430dd-2f65-413e-99e9-58aafa0f999c" StartPathNodeId="1c9962ec-fc9d-4708-bb1b-23514f98a10c" EndPathNodeId="4e813492-9609-42c1-a7ed-85e530a700cd" Weigh="1.000" Length="1.000" TrackType="1" Direction="1" PathType="0" ForwardStartID="02 30 30 30 30 30 30 30 30 31 30 0D 0A 03" ForwardEndID="02 30 30 30 30 30 30 30 30 30 31 0D 0A 03" BackwardEndID="" BackwardStartID="" AreaCode="S0_16">\
  <Points>-12.000 -1.000 -12.707 -0.707 -13.000 0.000 </Points>\
</Path>\
<Path Name="MN" ID="6e801f77-69a9-4e61-a9ab-5de728591389" StartPathNodeId="2b31f071-dc71-4d93-8c3c-b2911ca7e801" EndPathNodeId="018d2539-f45d-4816-8284-03ab6345e0cd" Weigh="1.000" Length="1.000" TrackType="1" Direction="1" PathType="0" ForwardStartID="02 30 34 31 35 41 41 45 33 43 43 0D 0A 03" ForwardEndID="02 30 30 30 30 30 30 30 30 31 31 0D 0A 03" BackwardEndID="" BackwardStartID="" AreaCode="S0_17">\
  <Points>-2.000 -1.000 -2.662 -0.775 -2.990 -0.396 </Points>\
</Path>\
<Path Name="NO" ID="3a48d134-c4fa-4272-9698-428748b84fda" StartPathNodeId="018d2539-f45d-4816-8284-03ab6345e0cd" EndPathNodeId="cced0c0e-c850-4504-a7fd-84d80d902eb2" Weigh="1.000" Length="1.000" TrackType="2" Direction="1" PathType="0" ForwardStartID="02 30 30 30 30 30 30 30 30 31 31 0D 0A 03" ForwardEndID="02 30 30 30 30 30 30 30 30 31 32 0D 0A 03" BackwardEndID="" BackwardStartID="" AreaCode="S0_18">\
  <Points>-2.990 -0.396 -3.411 0.042 -3.998 0.223 </Points>\
</Path>\
<Path Name="OP" ID="196004ea-ed81-4977-af89-49596d12e977" StartPathNodeId="cced0c0e-c850-4504-a7fd-84d80d902eb2" EndPathNodeId="7a7d9690-33f4-49b9-8279-6801fd77bfd6" Weigh="1.000" Length="1.000" TrackType="0" Direction="1" PathType="0" ForwardStartID="02 30 30 30 30 30 30 30 30 31 32 0D 0A 03" ForwardEndID="02 30 30 30 30 30 30 30 30 31 33 0D 0A 03" BackwardEndID="" BackwardStartID="" AreaCode="S0_19">\
  <Points>-3.998 0.223 -5.645 0.238 </Points>\
</Path>\
<Path Name="PQ" ID="7d2b5589-925b-444d-855c-1b9b437000df" StartPathNodeId="7a7d9690-33f4-49b9-8279-6801fd77bfd6" EndPathNodeId="1da83ec8-7771-4507-966d-b672f4f59b3c" Weigh="1.000" Length="1.000" TrackType="2" Direction="1" PathType="0" ForwardStartID="02 30 30 30 30 30 30 30 30 31 33 0D 0A 03" ForwardEndID="02 30 30 30 30 30 30 30 30 31 34 0D 0A 03" BackwardEndID="" BackwardStartID="" AreaCode="S0_20">\
  <Points>-5.645 0.238 -6.511 0.042 -6.988 -0.469 </Points>\
</Path>\
<Path Name="QR" ID="5bacef82-458f-46f0-b519-a46789643781" StartPathNodeId="1da83ec8-7771-4507-966d-b672f4f59b3c" EndPathNodeId="9d81b5d0-13ac-4b96-a379-9d6afe4d97d5" Weigh="1.000" Length="1.000" TrackType="1" Direction="1" PathType="0" ForwardStartID="02 30 30 30 30 30 30 30 30 31 34 0D 0A 03" ForwardEndID="02 30 34 31 35 41 41 45 33 33 36 0D 0A 03" BackwardEndID="" BackwardStartID="" AreaCode="S0_21">\
  <Points>-6.988 -0.469 -7.295 -0.809 -8.000 -1.000 </Points>\
</Path>\
<Path Name="SU" ID="85d878ce-9726-4ea4-9a46-d208f5b5508c" StartPathNodeId="b5f38612-a8a1-4e82-8df2-86f8254b966c" EndPathNodeId="e4036451-5291-42e8-9875-df5207b2a681" Weigh="1.000" Length="1.000" TrackType="1" Direction="1" PathType="0" ForwardStartID="02 30 34 31 35 41 41 45 33 41 31 0D 0A 03" ForwardEndID="02 31 32 33 34 35 36 37 38 39 30 0D 0A 03" BackwardEndID="" BackwardStartID="" AreaCode="S0_22">\
  <Points>-10.000 -1.000 -10.707 -0.707 -11.000 0.000 </Points>\
</Path>\
<Path Name="UV" ID="91734cab-3937-4d25-b344-911c41384ea3" StartPathNodeId="e4036451-5291-42e8-9875-df5207b2a681" EndPathNodeId="aa7fd80d-475a-4f9e-84a1-59d705c787f0" Weigh="1.000" Length="1.000" TrackType="0" Direction="1" PathType="0" ForwardStartID="02 31 32 33 34 35 36 37 38 39 30 0D 0A 03" ForwardEndID="02 30 30 30 30 30 30 30 30 31 36 0D 0A 03" BackwardEndID="" BackwardStartID="" AreaCode="S0_23">\
  <Points>-11.000 0.000 -11.000 2.000 </Points>\
</Path>\
<Path Name="VD" ID="b34540e7-b256-4e61-98c6-8ebf8f6b7203" StartPathNodeId="aa7fd80d-475a-4f9e-84a1-59d705c787f0" EndPathNodeId="6c44a292-2704-41dd-8f21-456f5b58187e" Weigh="1.000" Length="1.000" TrackType="1" Direction="1" PathType="0" ForwardStartID="02 30 30 30 30 30 30 30 30 31 36 0D 0A 03" ForwardEndID="02 30 30 30 30 30 30 30 30 30 34 0D 0A 03" BackwardEndID="" BackwardStartID="" AreaCode="S0_24">\
  <Points>-11.000 2.000 -10.707 2.707 -10.000 3.000 </Points>\
</Path>\
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
