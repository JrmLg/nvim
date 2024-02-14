import open from 'open'

for (const entry of process.argv.slice(2)) {
  await open(entry)
}
