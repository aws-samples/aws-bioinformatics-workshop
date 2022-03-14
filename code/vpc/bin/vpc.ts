#!/usr/bin/env node
import "source-map-support/register";
import * as cdk from "@aws-cdk/core";
import { VpcStack } from "../lib/vpc-stack";
import * as appConfig from "../app.json";

const app = new cdk.App();
new VpcStack(app, "VpcStack", {
  env: { account: appConfig.accountId, region: appConfig.region },
});
