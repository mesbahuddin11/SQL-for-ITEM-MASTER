create function dbo.GetDomain(
    @source varchar(1024),
    @delimiter varchar(10),
    @domain int
) returns varchar(1024) as begin
    declare @returnValue varchar(1024)
    declare @workingOn int
    declare @length int
    set @workingOn=0
    while @workingOn<@domain begin
        set @source=substring(@source,charindex(@delimiter,@source)+1,1024)
        set @workingOn+=1
    end
    set @length=charindex(@delimiter,@source)
    set @returnValue=substring(@source,1,case when @length=0 then 1024 else @length-1 end)
    return @returnValue
end
go