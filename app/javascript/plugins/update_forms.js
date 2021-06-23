import { initSelect2 } from "./init_select2";

export const updateTagModel = (id, tagModel) => {
  const url = `https://fipeapi.appspot.com/api/1/carros/veiculos/${id}.json`;
  fetch(url)
    .then((response) => response.json())
    .then((data) => {
      tagModel.innerHTML = ""; // clear second dropdown
      data.forEach((model) => {
        // create option elements to insert into the second dropdown
        const elem = `<option value="${model["name"].split(" ")[0]}">${
          model["name"]
        }</option>`;
        tagModel.insertAdjacentHTML("beforeend", elem); // insert options into the dropdown
      });
    });
  initSelect2();
};
