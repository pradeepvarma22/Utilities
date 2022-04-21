import Head from 'next/head';
import { useEffect, useRef, useState } from 'react';
import styles from '../styles/Home.module.css';
import Web3Modal from 'web3modal';
import { providers } from 'ethers';   //dont use providers from web3Modal use it from ethers


export default function Home() {

  const [walletConnected, setWalletConnected] = useState(false);
  const web3ModalRef = useRef();
  const [walletAddress, setWalletAddress] = useState("");


  const getWalletAddress = async () => {
    const signer_ = await getProviderOrSigner(true);
    const walletAddress_ = await signer_.getAddress();
    setWalletAddress(walletAddress_);
    console.log(walletAddress_);

  }

  const getProviderOrSigner = async (needSigner = false) => {

    try {
      const provider = await web3ModalRef.current.connect();           //its just take an instance
      const web3Provider = new providers.Web3Provider(provider);   //using that instance we can use all methods in web3Provider
      const { chainId } = await web3Provider.getNetwork();

      if (chainId != 4) {                       //4 is the id for rinkbey
        window.alert('change the network to rinkbey');

        throw new Error("change the network to rinkbey");
      }
      if (needSigner) {
        const signer = web3Provider.getSigner();
        // const walletAddress = await signer.getAddress();
        // console.log(walletAddress);
        return signer;
      }

      return web3Provider;
    }
    catch (err) {
      console.error(err);
    }


  }

  const connectWallet = async () => {

    try {

      await getProviderOrSigner();      //provider will connec with state of contract and get the data signer helps us to sign in a transaction
      setWalletConnected(true);
    }
    catch (err) {
      console.error(err);
    }

  }



  useEffect(() => {
    if (!walletConnected) {
      console.log('coonec');
      web3ModalRef.current = new Web3Modal({
        network: "rinkeby",                       //optional
        providerOptions: {},                      //required
        disabledInjectedProvider: false     //wallet that inject code into browser we need metamask
      });


    }

  }, [walletConnected]);




  return (
    <div className={styles.container}>
      <Head>
        <title>Web3Modal Login</title>
        <meta name="description" content="Web3Modal Login" />
        <link rel="icon" href="/favicon.ico" />
      </Head>

      <main className={styles.main}>
        Web3Modal Login<br />
        isConnected:
        <input value="connect" type="submit" onClick={connectWallet} />
        <br />
        <input type="submit" value="Wallet Address" onClick={getWalletAddress} />
        wallet Address: {walletAddress}
      </main>

      <footer className={styles.footer}>
        <a
          href=""
          target="_blank"
          rel="noopener noreferrer"
        >
          Powered by{' Varma '}
          <span className={styles.logo}>

          </span>
        </a>
      </footer>
    </div>
  )
}
