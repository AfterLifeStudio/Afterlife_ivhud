import { useState, useEffect } from "react";



const Compass = () => {
  const [status, setStatus] = useState({
    show: true,
    heading: 0,
  });


useEffect(() => {
  const element = document.getElementById("compass");
  let scroll = -((element.scrollWidth / (-360)) * status.heading)
  element.scrollLeft = scroll;
})



  return (
    <>
  <div className="compass-container">
    <div  id="compass" className="compass">

      <div className="compassvalues">
      <div className="compassbar"></div>
      <div className="compasstext">290</div>
      </div>


      <div className="compassvalues">
      <div className="compassbar"></div>
      <div className="compasstext">300</div>
      </div>

      <div className="compassvalues">
      <div className="compassbar"></div>
      <div className="compasstext">310</div>
      </div>


      <div className="compassvalues">
      <div className="compassdir">NW</div>
      </div>


    <div className="compassvalues">
      <div className="compassbar"></div>
      <div className="compasstext">320</div>
      </div>

      <div className="compassvalues">
      <div className="compassbar"></div>
      <div className="compasstext">330</div>
      </div>


      <div className="compassvalues">
      <div className="compassbar"></div>
      <div className="compasstext">340</div>
      </div>


      <div className="compassvalues">
      <div className="compassbar"></div>
      <div className="compasstext">350</div>
      </div>
      

      <div className="compassvalues">
      <div className="compassdir">N</div>
      </div>

      <div className="compassvalues">
      <div className="compassbar"></div>
      <div className="compasstext">10</div>
      </div>


      <div className="compassvalues">
      <div className="compassbar"></div>
      <div className="compasstext">20</div>
      </div>


      <div className="compassvalues">
      <div className="compassbar"></div>
      <div className="compasstext">30</div>
      </div>


      <div className="compassvalues">
      <div className="compassbar"></div>
      <div className="compasstext">40</div>
      </div>

      <div className="compassvalues">
      <div className="compassdir">NE</div>
      </div>

      <div className="compassvalues">
      <div className="compassbar"></div>
      <div className="compasstext">50</div>
      </div>


      <div className="compassvalues">
      <div className="compassbar"></div>
      <div className="compasstext">60</div>
      </div>


      <div className="compassvalues">
      <div className="compassbar"></div>
      <div className="compasstext">70</div>
      </div>


      <div className="compassvalues">
      <div className="compassbar"></div>
      <div className="compasstext">80</div>
      </div>


      <div className="compassvalues">
      <div className="compassdir">E</div>
      </div>


      <div className="compassvalues">
      <div className="compassbar"></div>
      <div className="compasstext">100</div>
      </div>


      <div className="compassvalues">
      <div className="compassbar"></div>
      <div className="compasstext">110</div>
      </div>

      <div className="compassvalues">
      <div className="compassbar"></div>
      <div className="compasstext">120</div>
      </div>


      <div className="compassvalues">
      <div className="compassbar"></div>
      <div className="compasstext">130</div>
      </div>

      <div className="compassvalues">
      <div className="compassdir">SE</div>
      </div>

      <div className="compassvalues">
      <div className="compassbar"></div>
      <div className="compasstext">140</div>
      </div>


      <div className="compassvalues">
      <div className="compassbar"></div>
      <div className="compasstext">150</div>
      </div>

      <div className="compassvalues">
      <div className="compassbar"></div>
      <div className="compasstext">160</div>
      </div>


      <div className="compassvalues">
      <div className="compassbar"></div>
      <div className="compasstext">170</div>
      </div>

      <div className="compassvalues">
      <div className="compassdir">S</div>
      </div>


      <div className="compassvalues">
      <div className="compassbar"></div>
      <div className="compasstext">190</div>
      </div>

      <div className="compassvalues">
      <div className="compassbar"></div>
      <div className="compasstext">200</div>
      </div>

      <div className="compassvalues">
      <div className="compassbar"></div>
      <div className="compasstext">210</div>
      </div>

      <div className="compassvalues">
      <div className="compassbar"></div>
      <div className="compasstext">220</div>
      </div>

      <div className="compassvalues">
      <div className="compassdir">SW</div>
      </div>

      <div className="compassvalues">
      <div className="compassbar"></div>
      <div className="compasstext">230</div>
      </div>


      <div className="compassvalues">
      <div className="compassbar"></div>
      <div className="compasstext">240</div>
      </div>

      <div className="compassvalues">
      <div className="compassbar"></div>
      <div className="compasstext">250</div>
      </div>

      <div className="compassvalues">
      <div className="compassbar"></div>
      <div className="compasstext">260</div>
      </div>


      <div className="compassvalues">
      <div className="compassdir">W</div>
      </div>


      <div className="compassvalues">
      <div className="compassbar"></div>
      <div className="compasstext">280</div>
      </div>

      <div className="compassvalues">
      <div className="compassbar"></div>
      <div className="compasstext">290</div>
      </div>


      <div className="compassvalues">
      <div className="compassbar"></div>
      <div className="compasstext">300</div>
      </div>

      <div className="compassvalues">
      <div className="compassbar"></div>
      <div className="compasstext">310</div>
      </div>


      <div className="compassvalues">
      <div className="compassdir">NW</div>
      </div>

      <div className="compassvalues">
      <div className="compassbar"></div>
      <div className="compasstext">320</div>
      </div>

      <div className="compassvalues">
      <div className="compassbar"></div>
      <div className="compasstext">330</div>
      </div>


      <div className="compassvalues">
      <div className="compassbar"></div>
      <div className="compasstext">340</div>
      </div>


      <div className="compassvalues">
      <div className="compassbar"></div>
      <div className="compasstext">350</div>
      </div>
      
      <div className="compassvalues">
      <div className="compassdir">N</div>
      </div>
      
    </div>

    <div className="location-container">
      <div className="location1">Los Santos</div>
      <div className="location-bar"></div>
      <div className="location2">Legion Square</div>
    </div>
  </div>

    </>
  );
};

export default Compass;
