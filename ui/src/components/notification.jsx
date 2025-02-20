import { useState } from "react";
import { NuiEvent } from "../hooks/NuiEvent";

function Notifications() {
  const [Data, setData] = useState(false);



  NuiEvent('notification',(message) => {
    setData(message)
    setTimeout(() => {
      setData(false)
    }, message.duration);
  })

  return (
    Data &&
    <>
      <div className="notification-wrapper">
        <div className="notification-container">
          <div className="notification-icon">
            <span class="material-symbols-outlined">{Data.icon ? Data.icon : 'info'}</span>
          </div>

          <div className="notification-title">{Data.title}</div>
          <div className="notification-description">{Data.description}</div>
        </div>
      </div>
    </>
  );
}

export default Notifications;
