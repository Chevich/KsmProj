alter function sta.isCorrectPersN(in persn varchar(14), in sexcode tinyint, in birthdate date) returns tinyint
begin
  declare isok tinyint;
  declare gendercode char(1);
  declare birthdatestr char(6);
  declare areacode char(1);
  declare areaindex char(3);
  declare ccode char(2);
  declare checksum tinyint;

  set isok = 0;

  if length(persn)=14 then
     set gendercode = substr(persn,1,1);
     if (sexcode=0 and gendercode='4') or (sexcode=1 and gendercode='3') then
        set birthdatestr = substr(persn,2,6);
        if birthdatestr=dateformat(birthdate,'ddmmyy') then
           set areacode = substr(persn,8,1);
           if areacode in ('À','Â','Å','Ê','Ì','Í','Î','Ð','Ñ','Ò','Õ') then
              set areaindex = substr(persn,9,3);
              if (substr(areaindex,1,1) between '0' and '9') and 
                 (substr(areaindex,2,1) between '0' and '9') and 
                 (substr(areaindex,3,1) between '0' and '9') then
                 set ccode = substr(persn,12,2);
                 if (substr(ccode,1,1) in ('À','Â','Å','Ê','Ì','Í','Î','Ð','Ñ','Ò','Õ')) and 
                    (substr(ccode,2,1) in ('À','Â','Å','Ê','Ì','Í','Î','Ð','Ñ','Ò','Õ')) then
                    set isok = 1;
                 end if;
              end if;
           end if;
        end if;
     end if;
  end if;

  return isok;
end;
