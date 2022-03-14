import * as cdk from "@aws-cdk/core";
import * as ec2 from "@aws-cdk/aws-ec2";
import * as appConfig from "../app.json";

export class VpcStack extends cdk.Stack {
  constructor(scope: cdk.Construct, id: string, props?: cdk.StackProps) {
    super(scope, id, props);

    cdk.Tags.of(scope).add("Environment", "Dev");
    cdk.Tags.of(scope).add("Project", "Biotech");

    const privateSubnet = {
      name: "Private",
      subnetType: ec2.SubnetType.PRIVATE_WITH_NAT,
    };

    const publicSubnet = {
      name: "Public",
      subnetType: ec2.SubnetType.PUBLIC,
    };

    const vpcProp = {
      cidr: appConfig.cidr,
      maxAzs: appConfig.maxAzs,
      subnetConfiguration: [privateSubnet, publicSubnet],
    };

    new ec2.Vpc(this, appConfig.vpcName, vpcProp);
  }
}
