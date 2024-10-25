import { React, useEffect, useState } from "react";
import Fade from "../../utils/fade";
import settingsicon from "../../Assets/settings.png";
import Option from "./option";
import { NuiEvent } from "../../hooks/NuiEvent";
import { nuicallback } from "../../utils/nuicallback";

const Settings = () => {
  const { classes } = styles();
  const [visible, setVisible] = useState(false)


  const handlesettings = (data) => {
    setSettings(data);
    setVisible(true)
  };

  NuiEvent("settings", handlesettings);

  useEffect(() => {

    const handlekey = (e) => {
      if (visible && e.code == 'Escape') {
        setVisible(false)
        nuicallback("exitsettings")
      }
    };

    window.addEventListener('keydown',handlekey);
    return () => window.removeEventListener('keydown',handlekey);
  })

  return (
    <>
      <Fade in={visible}>
        <div className={classes.settings}>
          <div className={classes.top}>
            <div className={classes.toptext}>
              <img src={settingsicon} alt="" />
              <p>SETTINGS</p>
            </div>
          </div>
          <div className={classes.map}>
            <div className={classes.catagory}>
              <p className={classes.catagorytitle}>General</p>
              <Option
                title={"Toggle Hud"}
                value={settings.showhud}
                option1={"SHOW"}
                option2={"HIDE"}
                option={"showhud"}
              />
              <Option
                title={"Cinemtic Mode"}
                value={settings.cinemtic}
                option1={"SHOW"}
                option2={"HIDE"}
                option={"cinemtic"}
              />
            </div>
            <div className={classes.catagory}>
              <p className={classes.catagorytitle}>Speedometer</p>
              <Option
                title={"Toggle Speedometer"}
                value={settings.showspeedometer}
                option1={"SHOW"}
                option2={"HIDE"}
                option={"showspeedometer"}
              />
              <Option
                title={"Speed Unit"}
                value={settings.speedunitmph}
                option1={"MPH"}
                option2={"KMH"}
                option={"speedunitmph"}
              />
            </div>
            <div className={classes.catagory}>
              <p className={classes.catagorytitle}>Minimap</p>
              <Option
                title={"Toggle Minimap"}
                value={settings.showminimap}
                option1={"SHOW"}
                option2={"HIDE"}
                option={"showminimap"}
              />
            </div>
            <div className={classes.catagory}>
              <p className={classes.catagorytitle}>Player Status</p>
              <Option
                title={"Toggle Status"}
                value={settings.showplayerstatus}
                option1={"SHOW"}
                option2={"HIDE"}
                option={"showplayerstatus"}
              />
            </div>
          </div>
          <div className={classes.bottom}>@AfterLife Studios</div>
          <div className={classes.keybind}>
            <p className={classes.key}>ESC</p>
            <p>EXIT</p>
          </div>
        </div>
      </Fade>
    </>
  );
};

export default Settings;
