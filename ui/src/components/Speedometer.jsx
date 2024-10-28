import { useState, useEffect } from "react";

import Fade from "../utils/fade";
import { NuiEvent } from "../hooks/NuiEvent";
import { useSelector } from 'react-redux'
import speedoutline from "../assets/images/speedometer-outline-status.png";
import fuel from "../assets/images/speedometer-fuel.png";
import engine from "../assets/images/speedometer-engine.png";
import caricon from "../assets/images/car-solid.png";
import seatbelticon from "../assets/images/user-slash-solid.png";
import fuelicon from "../assets/images/gas-pump-solid.png";
import alarm from "../assets/sound/alarm.mp3"

const Speedometer = () => {
  const [vehicle, setVehicle] = useState({
    show: true,
    mileage: 200,
    speed: 0,
    fuel: 70,
    gear: 2,
    engine: 40,
    rpm: 0.9,
    seatbelt: true,
  });



  const handlespeedometer = (data) => {
    setVehicle(data);
  };

  NuiEvent("speedometer", handlespeedometer);

  const settings = useSelector((state) => state.settings)

  let vehiclerpm = 300 / vehicle.rpm / 4;
  if (vehiclerpm < 81) {
    vehiclerpm = 80;
  }
  if (vehiclerpm > 300) {
    vehiclerpm = 300;
  }

  const gears = [6, 5, 4, 3, 2, 1, 0];

  const visible = settings.showspeedometer == true ? vehicle.show : false
console.log()

  useEffect(() => {
    const alarm = document.getElementById("alarm");
    if (!vehicle.seatbelt && settings.seatbeltalarm){
      alarm.play();
    }else {
      alarm.pause();
    }

  }, [vehicle.show,settings.seatbeltalarm])
  
  

  return (
    <>
    <Fade in={visible}>
      <div style={settings.fliphud ? {right: '2vw',transform: `scale(${settings.speedometersize})`} :{left: '2vw',transform: `scale(${settings.speedometersize})`}} className="speedometer">
        <svg height="13vw" width="13vw">
          <circle
            className="speedo-back"
            cx="50%"
            cy="50%"
            r="6.3vw"
            stroke="0f0f0fee"
            stroke-width=".4vw"
            fill="transparent"
          />
        </svg>
        <div className="box">
          <svg height="13vw" width="13vw">
            <circle
              className="outline"
              cx="50%"
              cy="50%"
              r="6vw"
              stroke="#414141"
              stroke-width=".2vw"
              fill="transparent"
            />
            <circle
              style={{ strokeDashoffset: vehiclerpm + "%" }}
              className="circlea"
              cx="50%"
              cy="50%"
              r="6vw"
              stroke="white"
              stroke-width=".2vw"
              fill="transparent"
            />
          </svg>
        </div>
        <div className="gear-container">
          {gears.map((gears) => (
            <p
              style={{ color: gears <= vehicle.gear ? "#88cfcd" : "white" }}
              className={`gear` + gears}
            >
              {gears}
            </p>
          ))}
        </div>

        <img className="speed-outline" src={speedoutline} alt="" />

        <img
          style={{
            clipPath: `polygon(0 ${100 - vehicle.fuel}%, 100% ${
              100 - vehicle.fuel
            }%, 100% 100%, 0% 100%)`,
          }}
          className="speed-fuel"
          src={fuel}
          alt=""
        />
        <img
          style={{
            clipPath: `polygon(0 ${100 - vehicle.engine}%, 100% ${
              100 - vehicle.engine
            }%, 100% 100%, 0% 100%)`,
          }}
          className="speed-engine"
          src={engine}
          alt=""
        />

        <img className="fas fa-car" src={caricon} />
        <img className="fas fa-gas-pump" src={fuelicon} />

        <div className="speedometer-center">
          <div className="speed-unit">{settings.speedunit}</div>

          <div className="speed">
            {vehicle.speed < 10 ? (
              <>
                <span style={{ opacity: "50%" }}>0</span>
                <span style={{ opacity: "50%" }}>0</span>
                <span>{vehicle.speed}</span>
              </>
            ) : vehicle.speed < 100 ? (
              <>
                <span style={{ opacity: "50%" }}>0</span>
                <span>{vehicle.speed}</span>
              </>
            ) : (
              <span>{vehicle.speed}</span>
            )}
          </div>

          <div className="mileage-container">
            <span>0</span>
            <span>0</span>
            <span>0</span>
            <span>0</span>
            <span>0</span>
            <span>1</span>
            <span>2</span>
          </div>
          {!vehicle.seatbelt && (
            <img className="fas seatbelt" src={seatbelticon} />
          )}
        </div>
        <audio id="alarm" src={alarm} loop preload></audio>

      </div>
      </Fade>
    </>
  );
};

export default Speedometer;
