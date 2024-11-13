import { useRef, useState, useEffect } from "react";
import Fade from "../utils/fade";
import { NuiEvent } from "../hooks/NuiEvent";
import { useSelector } from "react-redux";
import speedoutline from "../assets/images/speedometer-outline-status.png";
import fuel from "../assets/images/speedometer-fuel.png";
import engine from "../assets/images/speedometer-engine.png";
import caricon from "../assets/images/car-solid.png";
import seatbelticon from "../assets/images/user-slash-solid.png";
import fuelicon from "../assets/images/gas-pump-solid.png";
import alarmfile from "../assets//sound/alarm.mp3";

const Speedometer = () => {

  const audioelement = useRef();

  const [vehiclevisible, setVehicleVisible] = useState(false);

  const [vehicle, setVehicle] = useState({
    mileagec: false,
    mileage: 0,
    class: 0,
    speed: 0,
    fuel: 0,
    gear: 0,
    engine: 0,
    rpm: 0,
    seatbelt: true,
  });

  const handlevisible = (state) => {
    setVehicleVisible(state);
  };

  const handlespeedometer = (data) => {
    setVehicleVisible(data.show)
    setVehicle(data);
  };


  

  NuiEvent("speedometer", handlespeedometer);
  NuiEvent("speedometervisible", handlevisible);

  const settings = useSelector((state) => state.settings);

  let vehiclerpm = 300 / vehicle.rpm / 4;
  if (vehiclerpm < 81) {
    vehiclerpm = 80;
  }
  if (vehiclerpm > 300) {
    vehiclerpm = 300;
  }

  const mileage = Math.floor(vehicle.mileage).toString().padStart(8, "0")

  

  useEffect(() => {
    if (vehiclevisible && !vehicle.seatbelt && settings.seatbeltalarm){
      audioelement.current.play();
    }
    

  }, [vehiclevisible,vehicle.seatbelt,settings.seatbeltalarm])
  


  const gears = [6, 5, 4, 3, 2, 1, 0];

  const visible = settings.showspeedometer ? vehiclevisible : false;

  return (
    <>
      <Fade in={visible}>
        <div
          style={
            settings.fliphud
              ? {
                  right: "2vw",
                  transform: `scale(${settings.speedometersize / 50})`,
                }
              : {
                  left: "2vw",
                  transform: `scale(${settings.speedometersize / 50})`,
                }
          }
          className="speedometer"
        >
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

          {vehicle.class != 13 && (
            <>
              {vehicle.class != 16 && (
                <div className="gear-container">
                  {gears.map((gears) => (
                    <p
                      style={{
                        color: gears <= vehicle.gear ? "#88cfcd" : "white",
                      }}
                      className={`gear` + gears}
                    >
                      {gears}
                    </p>
                  ))}
                </div>
              )}

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
            </>
          )}

          <div className="speedometer-center">
            <div className="speed-unit">{settings.mphkmh ? "MPH" : "KMH"}</div>

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

            {vehicle.class == 13 ? (
              <svg
                xmlns="http://www.w3.org/2000/svg"
                fill="rgba(255,255,255,0.9)"
                viewBox="0 0 640 512"
              >
                <path d="M312 32c-13.3 0-24 10.7-24 24s10.7 24 24 24l25.7 0 34.6 64-149.4 0-27.4-38C191 99.7 183.7 96 176 96l-56 0c-13.3 0-24 10.7-24 24s10.7 24 24 24l43.7 0 22.1 30.7-26.6 53.1c-10-2.5-20.5-3.8-31.2-3.8C57.3 224 0 281.3 0 352s57.3 128 128 128c65.3 0 119.1-48.9 127-112l49 0c8.5 0 16.3-4.5 20.7-11.8l84.8-143.5 21.7 40.1C402.4 276.3 384 312 384 352c0 70.7 57.3 128 128 128s128-57.3 128-128s-57.3-128-128-128c-13.5 0-26.5 2.1-38.7 6L375.4 48.8C369.8 38.4 359 32 347.2 32L312 32zM458.6 303.7l32.3 59.7c6.3 11.7 20.9 16 32.5 9.7s16-20.9 9.7-32.5l-32.3-59.7c3.6-.6 7.4-.9 11.2-.9c39.8 0 72 32.2 72 72s-32.2 72-72 72s-72-32.2-72-72c0-18.6 7-35.5 18.6-48.3zM133.2 368l65 0c-7.3 32.1-36 56-70.2 56c-39.8 0-72-32.2-72-72s32.2-72 72-72c1.7 0 3.4 .1 5.1 .2l-24.2 48.5c-9 18.1 4.1 39.4 24.3 39.4zm33.7-48l50.7-101.3 72.9 101.2-.1 .1-123.5 0zm90.6-128l108.5 0L317 274.8 257.4 192z" />
              </svg>
            ) : vehicle.class == 16 ? (
              <svg
                xmlns="http://www.w3.org/2000/svg"
                fill="rgba(255,255,255,0.9)"
                viewBox="0 0 512 512"
              >
                <path d="M192 93.7C192 59.5 221 0 256 0c36 0 64 59.5 64 93.7l0 66.3L497.8 278.5c8.9 5.9 14.2 15.9 14.2 26.6l0 56.7c0 10.9-10.7 18.6-21.1 15.2L320 320l0 80 57.6 43.2c4 3 6.4 7.8 6.4 12.8l0 42c0 7.8-6.3 14-14 14c-1.3 0-2.6-.2-3.9-.5L256 480 145.9 511.5c-1.3 .4-2.6 .5-3.9 .5c-7.8 0-14-6.3-14-14l0-42c0-5 2.4-9.8 6.4-12.8L192 400l0-80L21.1 377C10.7 380.4 0 372.7 0 361.8l0-56.7c0-10.7 5.3-20.7 14.2-26.6L192 160l0-66.3z" />
              </svg>
            ) : vehicle.class == 8 ? (
              <svg xmlns="http://www.w3.org/2000/svg"fill="rgba(255,255,255,0.9)" viewBox="0 0 640 512">
                <path d="M280 32c-13.3 0-24 10.7-24 24s10.7 24 24 24l57.7 0 16.4 30.3L256 192l-45.3-45.3c-12-12-28.3-18.7-45.3-18.7L64 128c-17.7 0-32 14.3-32 32l0 32 96 0c88.4 0 160 71.6 160 160c0 11-1.1 21.7-3.2 32l70.4 0c-2.1-10.3-3.2-21-3.2-32c0-52.2 25-98.6 63.7-127.8l15.4 28.6C402.4 276.3 384 312 384 352c0 70.7 57.3 128 128 128s128-57.3 128-128s-57.3-128-128-128c-13.5 0-26.5 2.1-38.7 6L418.2 128l61.8 0c17.7 0 32-14.3 32-32l0-32c0-17.7-14.3-32-32-32l-20.4 0c-7.5 0-14.7 2.6-20.5 7.4L391.7 78.9l-14-26c-7-12.9-20.5-21-35.2-21L280 32zM462.7 311.2l28.2 52.2c6.3 11.7 20.9 16 32.5 9.7s16-20.9 9.7-32.5l-28.2-52.2c2.3-.3 4.7-.4 7.1-.4c35.3 0 64 28.7 64 64s-28.7 64-64 64s-64-28.7-64-64c0-15.5 5.5-29.7 14.7-40.8zM187.3 376c-9.5 23.5-32.5 40-59.3 40c-35.3 0-64-28.7-64-64s28.7-64 64-64c26.9 0 49.9 16.5 59.3 40l66.4 0C242.5 268.8 190.5 224 128 224C57.3 224 0 281.3 0 352s57.3 128 128 128c62.5 0 114.5-44.8 125.8-104l-66.4 0zM128 384a32 32 0 1 0 0-64 32 32 0 1 0 0 64z"/>
              </svg>
            ) : (
              <>
                {vehicle.mileagec == true && (
                  <div className="mileage-container">
                    <span>{mileage}</span>
                  </div>
                )}
                {!vehicle.seatbelt && (
                  <img className="fas seatbelt" src={seatbelticon} />
                )}
              </>
            )}
          </div>
        </div>
      </Fade>

      {vehiclevisible && !vehicle.seatbelt && settings.seatbeltalarm && (
        <audio ref={audioelement} id="alarm" src={alarmfile} loop />
      )}
    </>
  );
};

export default Speedometer;
