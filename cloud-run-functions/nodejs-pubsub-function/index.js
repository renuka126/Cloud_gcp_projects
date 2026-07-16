const functions = require('@google-cloud/functions-framework');

// Fires whenever a message is published to the 'cf-demo' topic.
// Pub/Sub message data always comes base64-encoded, so it has to be
// decoded before it's readable - that tripped me up the first time.


functions.cloudEvent('helloPubSub', cloudEvent => {
  const base64name = cloudEvent.data.message.data;

  const name = base64name
    ? Buffer.from(base64name, 'base64').toString()
    : 'World';

  console.log(`Hello, ${name}!`);
});