#!/usr/bin/env node
"use strict";

process.stdin.resume();
process.stdin.setEncoding("utf8");
process.stdin.on("data", function (data) {
    var revisionList = {};

    try {
        revisionList = JSON.parse(data);
    } catch (e) {
        console.error(e);
        return process.exit(1);
    }

    if (!revisionList.revisions.length) {
        console.error("No revisions have been deployed. Revisions: ", data);
        return process.exit(1);
    }

    process.stdout.write(revisionList.revisions[0].s3Location.key);
});
