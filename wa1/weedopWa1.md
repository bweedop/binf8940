# BINF 8940 - Writing Assignment 1

K. Bodie Weedop

__Notes:__
	- ssh MyID@teach.gacrc.uga.edu
	- All data necessary for this list is available at:  /work/binf8940/instructor_data/WA1_files/ 

## UNIX commands (paste your commands below each question):

1. Go into the subdirectory called "/work/binf8940/instructor_data/WA1_files/". Verify all data by doing "ls"

	```bash
	cd /work/binf8940/instructor_data/WA1_files/
	ls
	```

	- Copy the file "binf8940.txt" into "binf8940.txt.copy" in your home (~) directory.

		```bash
		# Going to home directory for the remaining questions
		cd ~/
		cp binf8940.txt ~/binf8940.txt.copy
		```

	- Rename the file "binf8940.txt.copy" to "binf8940_new".

		```bash
		mv binf8940.txt.copy binf8940_new
		```

	- Create a folder called "data" in your home directly.
	
		```bash
		mkdir data
		```
	
	- Move the file "binf8940_new" into the "data" new directory.

		```bash
		mv binf8940_new data/
		```

	- Create a new subdirectory called "new" in the "data" directory.
	
		```bash
		mkdir data/new
		```
	
	- Move the file "binf8940_new" in the "data" directory into the "new" directory.

		```bash
		mv data/binf8940_new data/new/
		```

	- Move the file "binf8940_new" in the "new" directory back into the "data" directory and change the name to "binf8940.old".

		```bash
		mv data/new/binf8940_new data/binf8940.old
		```
	
	- Delete the file "binf8940.old".

		```bash
		rm data/binf8940.old
		```
	
	- Remove the "new" subdirectory.
	
		```bash
		rm -r data/new/
		```

2. Copy the file "/work/binf8940/instructor_data/WA1_files/long_seq.fastq" into your home (~) directory.

	```bash
	cp /work/binf8940/instructor_data/WA1_files/long_seq.fastq ~/
	```
	
	- Display the file "long_seq.fastq" on the screen using "cat" command.

		```bash
		cat long_seq.fastq
		```

	- Same as 2a but use the "more" program instead (what is the difference?)
		* The difference is that `more` will print the document to the terminal by segments starting from the top. `cat` will print the entire document to the terminal at once.

		```bash
		more long_seq.fastq
		```

	- How many sequences we have in the “long_seq.fastq” file? (result + command)
		* 344081

		```bash
		expr $(cat long_seq.fastq | wc -l) / 4
		```

	- Search (grep) for the word "SRR" using the "more" and the "less" program, compare the results.
		* `more` shows the output page by page but `less` allows you to navigate up and down document.

		```bash
		cat long_seq.fastq | grep "SRR" | more
		cat long_seq.fastq | grep "SRR" | less
		```

	- Change the protection of your own file "long_seq.fastq" so that anyone may read it (access to all users).

		```bash
		chmod o+r long_seq.fastq
		```

## ALIGNMENT (post your commands)

1.	Also using files from ”/work/binf8940/instructor_data/WA1_files/” create a BLAST database using the “COVID19_genome.fasta”

		```bash
		formatdb -i COVID19_genome.fasta -p F -n CovidDB
		```

2.	Run a BLAST search using Gene.fasta (blastall -p blastn)

```bash
blastall -p blastn -d CovidDB -i Gene.fasta -o geneVsCovidDB.blastout
```

3.	What is the difference between adding the flag -m8 to your blastall command and not adding it? (try both!)
	* The `-m 8` tabulates the data output 

4.	Run BWA mem following the example below (copy all files to your home directory):

	- Illumina PE reads:
		* `/work/binf8940/instructor_data/WA1_files/covid_1.fastq`
		* `/work/binf8940/instructor_data/WA1_files/covid_2.fastq`
	- Reference genome:
		* `/work/binf8940/instructor_data/WA1_files/COVID19_genome.fasta`

	```bash
	cp /work/binf8940/instructor_data/WA1_files/covid_* ~/
	cp /work/binf8940/instructor_data/WA1_files/COVID19_genome.fasta ~/
	```

### Please use the GACRC software wiki to properly run jobs in the teaching cluster. (https://wiki.gacrc.uga.edu/wiki/Software)

- BWA mem:
	
	```bash
	# Example 1: (remember that the software version may change)
	ml SAMtools/1.10-foss-2016b
	ml BWA/0.7.17-GCC-8.3.0 
	bwa index Reference_Genome.fasta
	bwa mem Reference_Genome.fasta File_1.fastq File_2.fastq > out_algn_mem.sam 
	samtools view –b –S out_algn_mem.sam > out_algn_mem.bam
	samtools sort -o out_algn_mem.sorted.bam out_algn_mem.bam
	samtools index out_algn_mem.sorted.bam
	```
	
- Paste your final bash script (bwa.sh).

		```bash
		# bwa.sh
		ml SAMtools/1.10-foss-2016b
		ml BWA/0.7.17-GCC-8.3.0
		bwa index COVID19_genome.fasta
		bwa mem COVID19_genome.fasta covid_1.fastq covid_2.fastq > outAlgnMem.sam
		samtools view –b outAlgnMem.sam > outAlgnMem.bam
		samtools sort -o outAlgnMem.sorted.bam outAlgnMem.bam
		samtools index outAlgnMem.sorted.bam
		```

- How many reads mapped to the genome?
	* 1209112

	```bash
	samtools view -c -F 260 outAlgnMem.sorted.bam
	```

- What does “*” mean in the third column of the sam file?
	* The read was not mapped to the genome.


