import { React, useState } from "react";
import { nuicallback } from "../../utils/nuicallback";
import { Checkbox } from '@mantine/core';



const Button = (data) => {


  const [input, setinput] = useState(data.value);

  const handleinput = (option) => {
    let value = !input
    setinput(value)
    nuicallback("settings",{option,value})
  };

  return (
    <>
      <div className='option'>
        <div>{data.title}</div>
        <div className='select-value'>
          <div className="option-button-text">{input ? 'on' : 'off'}</div>
          <div style={{justifyContent: input ? 'end' : 'start'}} onClick={handleinput} className='option-button'>
            <div style={{opacity: input ? '100%' : '50%'}}></div>
          </div>
        </div>
      </div>
    </>
  );
};

export default Button;
