import Head from 'next/head'
import Image from 'next/image'
import styles from '../styles/Home.module.css'

export default function Home() {
  return (
    <div className={styles.container}>
      <Head>
        <title>Web3Modal Login</title>
        <meta name="description" content="Web3Modal Login" />
        <link rel="icon" href="/favicon.ico" />
      </Head>

      <main className={styles.main}>
        Web3Modal Login
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
