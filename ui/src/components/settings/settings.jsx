import { React, useEffect, useState } from "react";
import Fade from "../../utils/fade";
import settingsicon from "../../assets/images/settings.png";
import Select from "./select";
import Button from "./button";
import Sliders from "./slider";
import { NuiEvent } from "../../hooks/NuiEvent";
import { nuicallback } from "../../utils/nuicallback";
import { Config } from "./settingsdata";
const Settings = () => {
  const [settings, setSettings] = useState({
    catagory: "general",
  });

  const [catagorystate, setCatagory] = useState("general");
  const [visible, setVisible] = useState(true);
  const [description, setDescription] = useState("")
  const handlesettings = (data) => {
    setSettings(data);
    setVisible(true);
  };

  NuiEvent("settings", handlesettings);

  const handlehover = (value) => {
    setDescription(value)
  }

  useEffect(() => {
    const handlekey = (e) => {
      if (visible && e.code == "Escape") {
        setVisible(false);
        nuicallback("exitsettings");
      }
    };

    window.addEventListener("keydown", handlekey);
    return () => window.removeEventListener("keydown", handlekey);
  });

  const catagories = ["general", "minimap", "speedometer", "info"];

  return (
    <>
      <Fade in={visible}>
        <div className="settings-wrapper">
          <div className="settings-container">
            <div className="settings-title">
              <img src={settingsicon} alt="" />
              <div>SETTINGS</div>
            </div>
            <div className="settings-catagories">
              {catagories.map((catagory) => (
                <p
                  onClick={() => setCatagory(catagory)}
                  style={{
                    color: catagory == catagorystate ? "#88cfcd" : "white",
                  }}
                  className="settings-catagory"
                >
                  {catagory}
                </p>
              ))}
            </div>

            <div className="settings">
              <div className="settings-options">
                {Config.settings.map((data) => (
                  catagorystate == data.category &&
                  <>
                  {data.type == 'select'?
                  <div onMouseOver={() => handlehover(data.description)}>
                  <Select title={data.label} value={data.value} option1={data.option1} option2={data.option2} />
                  </div>
                  :data.type == 'button'?
                  <div onMouseOver={() => handlehover(data.description)}>
                  <Button title={data.label} value={data.value} />
                  </div>
                  : <div onMouseOver={() => handlehover(data.description)}>
                  <Sliders title={data.label} value={data.value} />
                  </div> 
                  }
                  </>
                ))}
              </div>
              <div className="instructions">
                {description}
              </div>
            </div>

            <div className="settings-keys-container">
            <div className="settings-keys">
            <div className="key">
                <div className="button">ENTER</div>
                <div className="action">APPLY</div>
              </div>
              <div className="key">
                <div className="button">BACKSPACE</div>
                <div className="action">RESET</div>
              </div>
              <div className="key">
                <div className="button">ESC</div>
                <div className="action">EXIT</div>
              </div>
            </div>
            </div>
          </div>
        </div>
      </Fade>
    </>
  );
};

export default Settings;
