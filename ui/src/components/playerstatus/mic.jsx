import { React, useState } from "react";
import mic from '../../Assets/mic.png';
import miclow from '../../Assets/miclow.png';
import micmed from '../../Assets/micmed.png';
import michigh from '../../Assets/michigh.png';


const Mic = (data) => {

  const mode = data.voicemode == 1 ? miclow : data.voicemode == 2 ? micmed : michigh

  return (
    <>
      <div>
        <img style={{width: data.size}} src={data.voice ? mode : mic} alt="" />
      </div>
    </>
  );
};

export default Mic;
