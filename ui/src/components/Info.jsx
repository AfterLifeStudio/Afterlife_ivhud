import { React, useState, useEffect } from "react";
import Fade from "../utils/fade";
import { NuiEvent } from "../hooks/NuiEvent";
import { useSelector } from "react-redux";
import AnimatedNumber from "animated-number-react";


const Info = () => {
  const [info, setInfo] = useState({
    bank: 2000,
    cash: 140,
    job: "Police - Officer",
  });

  const settings = useSelector((state) => state.settings);

  const handleinfo = (data) => {
    setInfo(data);
  };
  NuiEvent("info", handleinfo);

  const bank = (data) => {

  }

  const formatValue = (value) => value.toFixed(0);
  

  return (
    <>
      <Fade in={settings.showinfo}>
        <div class="info-wrapper">
          <div class="info-container">
            <div class="bank">
              <span>$</span>
              <AnimatedNumber formatValue={formatValue} value={info.bank}/>
            </div>
            <div class="cash">
              <span>$</span>
              <AnimatedNumber formatValue={formatValue} value={info.cash}/>
            </div>
            <div class="job">
              <span id="job">{info.job}</span>
            </div>
          </div>
        </div>
      </Fade>
    </>
  );
};

export default Info;
