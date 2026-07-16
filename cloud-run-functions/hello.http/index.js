const functions = require('@google-cloud/functions-framework');

// Simplest possible Cloud Run function - just responds to any HTTP request.
// Using a 600s timeout on deploy since HTTP functions sometimes need more
// than the default time to respond.

functions.http('helloWorld', (req, res) => {
  res.status(200).send('HTTP with Node.js in GCF 2nd gen!');
});