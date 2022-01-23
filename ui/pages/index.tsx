import type { NextPage } from 'next'
import Head from 'next/head'
import Card from '@mui/material/Card'
import TextField from '@mui/material/TextField'

const Home: NextPage = () => {
  return (
    <div>
      <Head>
        <title>Wedding RSVP System</title>
        <meta name="description" content="RSVP System for Weddings" />
        <link rel="icon" href="/favicon.ico" />
      </Head>

      <main>
        <Card>
          <TextField id="Email" label="Email" variant="outlined" required />
          <TextField id="Password" label="Password" variant="outlined" required />
        </Card>
      </main>

      <footer>

      </footer>
    </div>
  )
}

export default Home
