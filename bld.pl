#!/usr/bin/perl -w
use strict;


### MAIN

my $BL_LOG_DIR="/usr/nsh/NSH/Transactions/log";
my $bl_target_regx = qr/^bldeploy-\w*.log$/;

printf("BL LOG DIR is %s\n", ${BL_LOG_DIR});


my $log_file = get_recent_log(${BL_LOG_DIR}, ${bl_target_regx});
reduce_file(${log_file});


### End MAIN

sub reduce_file
{
   my ($file) = @{_};
   printf("LOG\t%s\n", ${file});
   my ($last_uniq_line, $last_uniq_msg) = '';
   my $counter = 0;
   my@file = read_file(${file});
   foreach my $line (@{file})
   {
      chomp($line);
      my ($info, $msg) = split(/-/, ${line});
      my ($date, $time, $type, $prg) = split(/\s+/, ${info});
#      print "${msg}\n";
#      print "$line\n";
      if ( ${msg} eq ${last_uniq_msg} )
         { ${counter}++; }
      else
      {
         printf("%s\n", ${line});
         if ( ${counter} == 0 )
         {
            ${last_uniq_msg} = ${msg};
            ${last_uniq_line} = ${line};
         }
         else
         {
            printf("COUNT\t%s\n", ${counter});
            ${counter} = 0;
         }
      }
   }       #       END @array
}

sub get_recent_log
{
   my ($log_dir, $regx) = @{_};
   my $recent_write_time = 0;
   my $recent_file = '';

   unless( -e ${log_dir} )
      { exit(); }
   opendir(DIR, ${log_dir}) or die("Could not open ${log_dir}  $!");
   while(defined(my $file = readdir(DIR)))
   {
      if ( ${file} =~ ${regx} )
      {
         my $log_file = ${log_dir} . "/" . $file;
         my $write_time = (stat(${log_file}))[9] or die("Could not stat ${file} $!");
         if ( $write_time > $recent_write_time)
         {
         ${recent_file} = ${log_file};
         $recent_write_time = $write_time;
         }
      }
   }

   closedir(DIR);
   return(${recent_file});
}   ### End get_recent_log

sub read_file
{
        my $filename = shift;
        open(FILE, "<$filename") or die "Can't open $filename: $!\n";
        chomp(my @file = <FILE>);
        close(FILE);
        return @file;
}       #       END read_file

sub print_array
{
        my @array = @_;
        foreach my $line (@array)
        {
                chomp($line);
                print "$line\n";
        }       #       END @array
}       #       END print_array
