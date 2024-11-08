import { React, useState, useEffect } from "react";
import Fade from "../utils/fade";
import Minimap from "./Minimap";
import Speedometer from "./Speedometer";
import Compass from "./Compass";
import Settings from "./settings/settings";
import { NuiEvent } from "../hooks/NuiEvent";
import { useSelector } from "react-redux";
import Info from "./Info";
const Hud = () => {
  const [visible, setVisible] = useState(false);

  const settings = useSelector((state) => state.settings)
  const handlevisible = (data) => {
    setVisible(data);
  };
  NuiEvent("visible", handlevisible);



  return (
    <>
      <Fade in={visible}>
        <Info />
        <Speedometer />
        <Minimap />
        <Compass />
      </Fade>
      <Settings />
    </>
  );
};

export default Hud;
