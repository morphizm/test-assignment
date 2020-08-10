/* eslint-disable no-undef */
const formattedTime = (rawMinutes) => {
  const hours = Math.floor(rawMinutes / 60);
  const formattedHours = hours >= 10 ? hours : `0${hours}`;

  const minutes = rawMinutes % 60;
  const formattedMinutes = minutes >= 10 ? minutes : `0${minutes}`;

  return `${formattedHours}:${formattedMinutes}`;
};

document.addEventListener('turbolinks:load', () => {
  const leftTimeElement = document.querySelector('[data-left-time]');

  if (leftTimeElement) {
    let time = Math.round(Number(leftTimeElement.dataset.leftTime));
    leftTimeElement.innerHTML = `Time left ${formattedTime(time)}`;

    timerId = setInterval(() => {
      time -= 1;
      if (!leftTimeElement) {
        clearInterval(timerId);
        return;
      }
      if (time <= 10) {
        document.querySelector('form').submit();
        clearInterval(timerId);
      }
      leftTimeElement.innerHTML = `Time left ${formattedTime(time)}`;
    }, 1000);
  }
});
