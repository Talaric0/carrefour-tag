import mapboxgl from "mapbox-gl";
import "mapbox-gl/dist/mapbox-gl.css";

const initMapbox = () => {
  const mapElement = document.getElementById("map");
  const fitMapToMarkers = (map, markers) => {
    const bounds = new mapboxgl.LngLatBounds();
    markers.forEach((marker) => bounds.extend([marker.lng, marker.lat]));
    map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 });
  };

  if (mapElement) {
    // only build a map if there's a div#map to inject into
    mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;
    const map = new mapboxgl.Map({
      container: "map",
      style: "mapbox://styles/gianpaolopapaiz/ckqcesexl4e8e17n2cqjo4aqd",
      pitch: 60,
      animate: true,
      duration: 300,
    });
    const markers = JSON.parse(mapElement.dataset.markers);
    markers.forEach((marker) => {
      const popup = new mapboxgl.Popup().setHTML(marker.info_window);
      const m = new mapboxgl.Marker()
        .setLngLat([marker.lng, marker.lat])
        .setPopup(popup)
        .addTo(map);
    });

    fitMapToMarkers(map, markers);

    if (document.querySelectorAll(".map-link")) {
      const mapLinks = document.querySelectorAll(".map-link");
      mapLinks.forEach((mapLink) => {
        mapLink.addEventListener("click", (event) => {
          event.preventDefault();
          map._markers.forEach((mapMarker) => {
            mapMarker._popup.remove();
            if (
              mapMarker._lngLat.lng ===
                parseFloat(mapLink.getAttribute("lng")) &&
              mapMarker._lngLat.lat === parseFloat(mapLink.getAttribute("lat"))
            ) {
              const mapContainer = document.getElementById("map");
              mapContainer.scrollIntoView({ behavior: "smooth" });
              map.flyTo({
                center: Object.values(mapMarker._lngLat),
                zoom: 9,
                speed: 0.2,
                curve: 1,
              });
              setTimeout(() => {
                mapMarker.togglePopup();
              }, 700);
            }
          });
        });
      });
    }
  }
};

export { initMapbox };
