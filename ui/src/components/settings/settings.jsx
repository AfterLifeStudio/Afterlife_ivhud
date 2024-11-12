import { React, useEffect, useState } from "react";
import Fade from "../../utils/fade";
import settingsicon from "../../assets/images/settings.png";
import Select from "./select";
import Button from "./button";
import Sliders from "./slider";
import { NuiEvent } from "../../hooks/NuiEvent";
import { nuicallback } from "../../utils/nuicallback";
import { useDispatch } from "react-redux";
import { useSelector } from 'react-redux'
import { update } from "../../store/settings/settingsSlice";
import { settingsdata } from "./settingsdata";

const Settings = () => {
  const [catagorystate, setCatagory] = useState("general");
  const [visible, setVisible] = useState(false);
  const [description, setDescription] = useState("")
  const [SettingsData, setSettingsData] = useState(settingsdata)

  const dispatch = useDispatch();


  const handlesettings = (data) => {
    setVisible(data.visible);
    dispatch(update(data.settings))
    setSettingsData(data.configsettings)
  };

  NuiEvent("settings", handlesettings);

  const handlehover = (value) => {
    setDescription(value)
  }


  useEffect(() => {

    const handlekey = (e) => {
      if (visible) {
        if (e.code == "Escape") {
          setVisible(false);
          setSettingsData([]); 
          setCatagory("general")
          nuicallback("exitsettings", SettingsData);
        } else if (e.code == "Enter") {
          setSettingsData([]); 
          setCatagory("general")
          nuicallback("settingsconfirm")
        } else if (e.code == "Backspace") {
          setSettingsData([]); 
          setCatagory("general")
          nuicallback("settingsreset")
        }
      }
    };

    window.addEventListener("keydown", handlekey);
    return () => window.removeEventListener("keydown", handlekey);
  });

  let optionscomponent = [];
  
  for (var i in SettingsData) {
    let data = SettingsData[i];
    if (catagorystate == data.category) {
      optionscomponent.push(
        <>
          {data.type == "select" ? (
            <div onMouseOver={() => handlehover(data.description)}>
              <Select
                title={data.label}
                name={data.name}
                value={data.value}
                option1={data.option1}
                option2={data.option2}
              />
            </div>
          ) : data.type == "button" ? (
            <div onMouseOver={() => handlehover(data.description)}>
              <Button title={data.label} name={data.name} value={data.value} />
            </div>
          ) : (
            <div onMouseOver={() => handlehover(data.description)}>
              <Sliders title={data.label} name={data.name} value={data.value} />
            </div>
          )}
        </>
      );
    }
  }


  const catagories = ["general", "minimap", "speedometer", "compass"];

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
                <div
                  onClick={() => {
                    setCatagory(catagory)
                    nuicallback('clicksound')
                  }}
                  style={{
                    color: catagory == catagorystate ? "#88cfcd" : "rgba(266,266,266,0.7)",
                  }}
                  className="settings-catagory"
                >
                  {catagory}
                </div>
              ))}
            </div>

            <div className="horizontalline"></div>

            <div className="settings">
              <div className="settings-options">
                {optionscomponent}
              </div>
              <div className="verticallline"></div>
              <div className="instructions">
                <span className="i">i</span> .{description}
              </div>
            </div>

            {/* <div className="horizontalline"></div> */}

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
