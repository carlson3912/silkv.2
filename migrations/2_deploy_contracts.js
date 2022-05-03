var SILK = artifacts.require("Silk");
module.exports = function(deployer) {
    deployer.deploy(SILK, "silk");
    // Additional contracts can be deployed here
};