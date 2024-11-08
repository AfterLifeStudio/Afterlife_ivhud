import { useState, useEffect } from "react";
import Fade from "../utils/fade";
import { NuiEvent } from "../hooks/NuiEvent";
import { useSelector } from "react-redux";
import outline from "../Assets/images/minimap-outline.png";
import minimapdead from "../Assets/images/minimap-dead.png";
import statusoutline from "../Assets/images/minimap-status-outline.png";
import health from "../Assets/images/minimap-health.png";
import armour from "../Assets/images/minimap-armour.png";
import hunger from "../Assets/images/minimap-hunger.png";
import thirst from "../Assets/images/minimap-thirst.png";
import stress from "../Assets/images/minimap-stress.png";
import extrastatus from "../Assets/images/minimap-statusextra.png";
import brain from "../Assets/images/brain-solid.png";
import droplet from "../Assets/images/droplet-solid.png";
import burger from "../Assets/images/burger-solid.png";
import lungs from "../Assets/images/lungs-solid.png";
import mic from "../Assets/images/microphone-solid.png";



const Minimap = () => {
  const [status, setStatus] = useState({
    skull: true,
    health: 50,
    armour: 50,
    oxygen: 50,
    hunger: 50,
    thirst: 50,
    stress: 50,
    voice: true,
    voicemode: 1,
  });

  const handlestatus = (data) => {
    setStatus(data);
  };

  NuiEvent("status", handlestatus);


  const handlevoicemode = (data) => {
    let r = document.querySelector(':root');

    if (data == 1) {
      r.style.setProperty('--voiceval', '#dec56f');
    }
    if (data == 2) {
      r.style.setProperty('--voiceval', '#88cfcd');
    }
    if (data == 3) {
      r.style.setProperty('--voiceval', '#e07569');
    }
  }

  NuiEvent("voicemode", handlevoicemode);

  const settings = useSelector((state) => state.settings)



  return (
    <>
    <Fade in={settings.showminimap}>
      <div style={settings.fliphud ? {left: '1.2vw', transform: `scale(${settings.minimapsize / 50})`} : {right: '1.2vw', transform: `scale(${settings.minimapsize / 50})`}} className="Minimap">
        <img className="outline" src={outline} alt="" />
        <Fade in={settings.skullonfoot ? status.skull : false}>
          <img className="minimap-dead" src={minimapdead} alt="" />
        </Fade>

        <img style={{clipPath: `polygon(0 ${100 - status.health}%, 100% ${100 - status.health}%, 100% 100%, 0% 100%)`}} className="health" src={health} alt="" />
        <img style={{clipPath: `polygon(0 ${100 - status.armour}%, 100% ${100 - status.armour}%, 100% 100%, 0% 100%)`}} className="armour" src={armour} alt="" />
        {settings.minimapextrastatus &&
        <>
        <img className="status-outline" src={statusoutline} alt="" />
        <img style={{clipPath: `polygon(0 ${100 - status.hunger}%, 100% ${100 - status.hunger}%, 100% 100%, 0% 100%)`}} className="hunger" src={hunger} alt="" />
        <img style={{clipPath: `polygon(0 ${100 - status.thirst}%, 100% ${100 - status.thirst}%, 100% 100%, 0% 100%)`}} className="thirst" src={thirst} alt="" />
        <img style={{clipPath: `polygon(0 ${100 - status.stress}%, 100% ${100 - status.stress}%, 100% 100%, 0% 100%)`}} className="stress" src={stress} alt="" />
        <img style={{clipPath: `polygon(0 ${100 - status.oxygen}%, 100% ${100 - status.oxygen}%, 100% 100%, 0% 100%)`}} className="oxygen" src={extrastatus} alt="" />
        <img className="fas icon-stress" src={brain} alt="" />
        <img className="fas icon-thirst" src={droplet} alt="" />
        <img className="fas icon-hunger" src={burger} alt="" />
        <img className="fas icon-oxygen" src={lungs} alt="" />
        </>
        }
        {status.voice &&
        <div style={settings.fliphud ? {right: '0.95vw'} : {left: '0.95vw'}} className="circle"></div>
      }
        <img style={settings.fliphud ? {right: '0vw'} : {left: '0vw'}} className="fa-microphone" src={mic} alt="" />
 

      </div>
      </Fade>
    </>
  );
};

export default Minimap;
