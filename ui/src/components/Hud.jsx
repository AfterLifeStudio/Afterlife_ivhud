import { React, useState, useEffect } from "react";
import Fade from "../utils/fade";
import { createStyles } from "@mantine/emotion";
import Minimap from "./Minimap";
import Speedometer from "./Speedometer";
import Compass from "./Compass";
import Playerstatus from "./playerstatus/Playerstatus";
import Settings from "./settings/settings";
import { NuiEvent } from "../hooks/NuiEvent";


               
const Hud = () => {
  const [visible, setVisible] = useState(true);


  const handlevisible = (data) => {
    setVisible(data);
  }
  NuiEvent("visible", handlevisible)


  return (
    <>
    <Speedometer/>
    <Minimap />
    <Compass/>
    </>
  );
};

export default Hud;
