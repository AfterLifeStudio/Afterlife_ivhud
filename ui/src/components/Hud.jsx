import { React, useState, useEffect } from "react";
import Fade from "../utils/fade";
import Minimap from "./Minimap";
import Speedometer from "./Speedometer";
import Compass from "./Compass";
import Settings from "./settings/settings";
import { NuiEvent } from "../hooks/NuiEvent";

const Hud = () => {
  const [visible, setVisible] = useState(false);

  const handlevisible = (data) => {
    setVisible(data);
  };
  NuiEvent("visible", handlevisible);

  return (
    <>
      <Fade in={visible}>
        <Speedometer />
        <Minimap />
        <Compass />
      </Fade>
      <Settings />
    </>
  );
};

export default Hud;
