export const updateTagModel = (id, tagModel) => {
  const url = `https://fipeapi.appspot.com/api/1/carros/veiculos/${id}.json`;
  fetch(url)
    .then((response) => response.json())
    .then((data) => {
      tagModel.innerHTML = ""; // clear second dropdown
      data.forEach((model) => {
        const elem = `<option value="${model["name"].split(" ")[0]}">${
          model["name"]
        }</option>`; // create option elements to insert into the second dropdown, bank_name is the chosen label method in the form
        tagModel.insertAdjacentHTML("beforeend", elem); // insert options into the dropdown
      });
    });
};
