let config = {
  forms: [
    {
      id: "modal-callback", // ID формы
      insertion: {
        element: "button[type='submit']", // Элемент рядом с которым будет вставка кнопки
        side: "before", // after or before - положение относительно insertion.element
      },
    },
  ],
};

export default config;
