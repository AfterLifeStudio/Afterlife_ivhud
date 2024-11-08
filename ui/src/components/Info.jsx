import { React, useState, useEffect } from "react";
import Fade from "../utils/fade";
import { NuiEvent } from "../hooks/NuiEvent";
import { useSelector } from "react-redux";
import AnimatedNumbers from "react-animated-numbers";

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

  return (
    <>
      <Fade in={settings.showinfo}>
        <div class="info-wrapper">
          <div class="info-container">
            <div class="bank">
              <span>$</span>
              <AnimatedNumbers
                transitions={(index) => ({
                  type: "spring",
                  duration: index + 0.3,
                })}
                animateToNumber={info.bank}
              />
            </div>
            <div class="cash">
              <span>$</span>
              <AnimatedNumbers
                fontStyle={{
                  fontSize: "1.2vw",
                }}
                transitions={(index) => ({
                  type: "spring",
                  duration: index + 0.3,
                })}
                animateToNumber={info.cash}
              />
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
