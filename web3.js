// Import the Web3 library
const Web3 = require('web3');

// Connect to the local Ethereum node
const web3 = new Web3('http://localhost:8545'); // Replace with your Ethereum node URL

// Set the contract address and ABI
const contractAddress = '0xd9145CCE52D386f254917e481eB44e9943F39138';
const contractABI = [
  [
    {
      "inputs": [],
      "stateMutability": "nonpayable",
      "type": "constructor"
    },
    {
      "inputs": [],
      "name": "owner",
      "outputs": [
        {
          "internalType": "address",
          "name": "",
          "type": "address"
        }
      ],
      "stateMutability": "view",
      "type": "function"
    }
  ]
];

// Create an instance of the contract
const contract = new web3.eth.Contract(contractABI, contractAddress);

// Get the current account
let currentAccount;

// Function to update the current account
async function updateAccount() {
  const accounts = await web3.eth.getAccounts();
  currentAccount = accounts[0];
}

// Function to vote
async function vote(amount) {
  try {
    await contract.methods.vote(amount).send({ from: currentAccount });
    console.log('Vote successful');
  } catch (error) {
    console.error('Vote failed:', error);
  }
}

// Function to get the current votes
async function getCurrentVotes() {
  const votes = await contract.methods.currentVotes().call();
  console.log('Current Votes:', votes);
}

// Function to validate the program
async function validateProgram() {
  try {
    await contract.methods.validate().send({ from: currentAccount });
    console.log('Program validation successful');
  } catch (error) {
    console.error('Program validation failed:', error);
  }
}

// Run the example functions
async function runExample() {
  await updateAccount();
  await vote(5);
  await getCurrentVotes();
  await validateProgram();
}

runExample();
