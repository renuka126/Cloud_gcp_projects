const functions = require('@google-cloud/functions-framework');

// This one only runs when a file gets uploaded to a specific GCS bucket.
// cloudevent carries all the metadata about the file - I just logged it
// out here to actually see what fields are available.

functions.cloudEvent('helloStorage', (cloudevent) => {
  console.log('Cloud Storage event with Node.js in GCF 2nd gen!');
  console.log(cloudevent);
});