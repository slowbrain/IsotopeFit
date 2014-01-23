function IsotopeFit()

scrsz = get(0,'ScreenSize'); 

Parent = figure( ...
    'MenuBar', 'none', ...
    'ToolBar','figure',...
    'NumberTitle', 'off', ...
    'Name', 'Mass-offset and resolution calibration',...
    'Units','normalized',...
    'Position',[0.2,0.2,0.6,0.6]); 

%Preview Panel

dataaxes = axes('Parent',Parent,...
             'ActivePositionProperty','OuterPosition',...
             'ButtonDownFcn','disp(''axis callback'')',...
             'Units','normalized',...
             'Position',gridpos(6,8,4,6,1,6,0.05,0.04)); 

areaaxes = axes('Parent',Parent,...
             'ActivePositionProperty','OuterPosition',...
             'ButtonDownFcn','disp(''axis callback'')',...
             'Units','normalized',...
             'Position',gridpos(6,8,1,3,2,6,0.05,0.04)); 

e_searchstring=uicontrol(Parent,'Style','edit',...
    'Tag','e_searchstring',...
    'Units','normalized',...
    'String','N/A',...
    'Background','white',...
    'Enable','on',...
    'Position',gridpos(12,16,6,6,1,1,0.01,0.02));         
         
uicontrol(Parent,'style','pushbutton',...
          'string','Sort List',...
          'Callback',@sortlistclick,...
          'Units','normalized',...
          'Position',gridpos(12,16,6,6,2,2,0.01,0.02));

ListSeries=uicontrol(Parent,'Style','Listbox',...
    'Units','normalized',...
    'Callback',@listseriesclick,...
    'Position',gridpos(12,16,1,5,1,2,0.01,0.02));
    
uicontrol(Parent,'Style','Text',...
    'String','Molecules',...
    'Units','normalized',...
    'Position',gridpos(18,8,18,18,7,8,0.01,0.01));         

ListMolecules=uicontrol(Parent,'Style','Listbox',...
    'Units','normalized',...
    'Callback',@moleculelistclick,...
    'Position',gridpos(18,8,8,17,7,8,0.01,0.01));

uicontrol(Parent,'style','pushbutton',...
          'string','Add Molecules',...
          'Callback','',...
          'Units','normalized',...
          'Position',gridpos(18,8,7,7,7,8,0.01,0.01)); 

uicontrol(Parent,'Style','Text',...
    'String','Center of mass: N/A',...
    'Units','normalized',...
    'Position',gridpos(18,8,6,6,7,8,0.01,0.01));

% uicontrol(Parent,'Style','Text',...
%     'String','Resolution: N/A',...
%     'Units','normalized',...
%     'Position',gridpos(18,8,5,5,7,8,0.01,0.01));



uicontrol(Parent,'Style','Text',...
    'String','Resolution',...
    'Units','normalized',...
    'Position',gridpos(18,24,5,5,19,20,0.01,0.01));

e_resolution=uicontrol(Parent,'Style','edit',...
    'Tag','e_resolution',...
    'Units','normalized',...
    'String','N/A',...
    'Background','white',...
    'Callback',@parametereditclick,...
    'Enable','off',...
    'Position',gridpos(18,24,5,5,21,22,0.01,0.01));

up1=uicontrol(Parent,'style','pushbutton',...
    'Tag','resolutionup',...
    'string','+',...
    'Callback',@parameterchange,...
    'Enable','off',...
    'Units','normalized',...
    'Position',gridpos(18,26,5,5,25,25,0.005,0.01));

down1=uicontrol(Parent,'style','pushbutton',...
    'Tag','resolutiondown',...    
    'string','-',...
    'Callback',@parameterchange,...
    'Enable','off',...
    'Units','normalized',...
    'Position',gridpos(18,26,5,5,26,26,0.005,0.01));  

uicontrol(Parent,'Style','Text',...
    'String','Offset',...
    'Units','normalized',...
    'Position',gridpos(18,24,4,4,19,20,0.01,0.01));

e_massoffset=uicontrol(Parent,'Style','edit',...
    'Tag','e_massoffset',...
    'Units','normalized',...
    'String','N/A',...
    'Background','white',...
    'Callback',@parametereditclick,...
    'Enable','off',...
    'Position',gridpos(18,24,4,4,21,22,0.01,0.01));

up2=uicontrol(Parent,'style','pushbutton',...
    'Tag','massup',...
    'string','+',...
    'Callback',@parameterchange,...
    'Enable','off',...
    'Units','normalized',...
    'Position',gridpos(18,26,4,4,25,25,0.005,0.01));

down2=uicontrol(Parent,'style','pushbutton',...
    'Tag','massdown',...    
    'string','-',...
    'Callback',@parameterchange,...
    'Enable','off',...
    'Units','normalized',...
    'Position',gridpos(18,26,4,4,26,26,0.005,0.01));  

uicontrol(Parent,'Style','Text',...
    'String','Area',...
    'Units','normalized',...
    'Position',gridpos(18,24,3,3,19,20,0.01,0.01));

e_area=uicontrol(Parent,'Style','edit',...
    'Tag','e_area',...
    'Units','normalized',...
    'String','N/A',...
    'Background','white',...
    'Callback',@parametereditclick,...
    'Enable','off',...
    'Position',gridpos(18,24,3,3,21,22,0.01,0.01));

up3=uicontrol(Parent,'style','pushbutton',...
    'Tag','areaup',...
    'string','+',...
    'Callback',@parameterchange,...
    'Enable','off',...
    'Units','normalized',...
    'Position',gridpos(18,26,3,3,25,25,0.005,0.01));

down3=uicontrol(Parent,'style','pushbutton',...
    'Tag','areadown',...    
    'string','-',...
    'Callback',@parameterchange,...
    'Enable','off',...
    'Units','normalized',...
    'Position',gridpos(18,26,3,3,26,26,0.005,0.01));  


uicontrol(Parent,'style','pushbutton',...
          'string','Fit this',...
          'Callback',@fitbuttonclick,...
          'Units','normalized',...
          'Position',gridpos(18,16,1,2,13,13,0.01,0.04)); 
      
uicontrol(Parent,'style','pushbutton',...
          'string','Fit all',...
          'Callback',@fitbuttonclick,...
          'Units','normalized',...
          'Position',gridpos(18,16,1,2,14,14,0.01,0.04));
      
uicontrol(Parent,'style','popupmenu',...
          'string',{'Ranges', 'Molecules'},...
          'Units','normalized',...
          'Position',gridpos(18,16,1,2,15,16,0.01,0.04));

%######################### MENU BAR

mfile = uimenu('Label','File');
    uimenu(mfile,'Label','Testdata','Callback',@test);
    uimenu(mfile,'Label','Save','Callback',@save_file);
    uimenu(mfile,'Label','Open','Callback',@open_file);
    uimenu(mfile,'Label','Quit','Callback','exit',... 
           'Separator','on','Accelerator','Q');
       
 mmolecules= uimenu('Label','Molecules','Enable','off');
       uimenu(mmolecules,'Label','Load from folder...','Callback',@menuloadmoleculesfolder);
       uimenu(mmolecules,'Label','Load from ifd...','Callback',@menuloadmoleculesifd);
       
 mcal= uimenu('Label','Calibration');
       mcalbgc=uimenu(mcal,'Label','Background correction...','Callback',@menubgcorrection,'Enable','off');
       mcalcal=uimenu(mcal,'Label','Mass- and Resolution calibration...','Callback',@menucalibration,'Enable','off');
 
 mdata= uimenu('Label','Data');
       mdataexport=uimenu(mdata,'Label','Export Data...','Callback',@menuexportdataclick,'Enable','on');
       
       
%######################### END OF LAYOUT     
      
addpath('DERIVESTsuite');
addpath('FMINSEARCHBND');

handles=guidata(Parent);
%bg correction standard values
handles.bgcorrectiondata.startmass=-inf;
handles.bgcorrectiondata.endmass=+inf;
handles.bgcorrectiondata.ndiv=10;
handles.bgcorrectiondata.polydegree=3;
handles.bgcorrectiondata.percent=50;
handles.bgcorrectiondata.bgpolynom=0;

%initial calibration data
handles.calibration=standardcalibration();
guidata(Parent,handles);
    
    function menuexportdataclick(hObject,eventdata)
        handles=guidata(hObject);

        searchstring=get(e_searchstring,'String');        
        [handles.seriesarea,handles.seriesareaerror,serieslist]=sortmolecules(handles.molecules,searchstring);
        guidata(hObject,handles);
        
        [filename, pathname, filterindex] = uiputfile( ...
            {'*.*','ASCII data (*.*)'},...
            'Export data');
        handles=guidata(Parent);
        
        if ~(isequal(filename,0) || isequal(pathname,0))
            fid=fopen(fullfile(pathname,filename),'w');
            
            fprintf(fid,'\t');
            for i=1:length(serieslist)
                fprintf(fid,'%s\t(error)\t',serieslist{i});
            end
            fprintf(fid,'\n');
            %size(handles.seriesarea,1)
            for i=1:size(handles.seriesarea,1)
                fprintf(fid,'%i\t',i-1);
                for j=1:size(handles.seriesarea,2)
                    fprintf(fid,'%e\t%e\t',handles.seriesarea(i,j),handles.seriesareaerror(i,j));
                end
                fprintf(fid,'\n');
            end
        end
    end

    function listseriesclick(hObject,eventdata)
        handles=guidata(hObject);

        ix=get(ListSeries,'Value');
        
        j=1;
        for i=1:size(handles.seriesarea,1)
            if (handles.seriesarea(i,ix)~=0)||(handles.seriesareaerror(i,ix)~=0)
                n(j)=i-1;
                data(j)=handles.seriesarea(i,ix);
                dataerror(j)=handles.seriesareaerror(i,ix);
                j=j+1;
            end
        end
        
        
        %area(areaaxes,n,data+dataerror,data-dataerror,'Facecolor',[0.7,0.7,0.7],'Linestyle','none');
        
        plot(areaaxes,n,data,'k--');
        hold on;
        
        p=stem(areaaxes,n,data,'filled','+k'); 
        
        p=stem(areaaxes,n,data+dataerror,'Marker','v','Color','b','LineStyle','none');
        p=stem(areaaxes,n,data-dataerror,'Marker','^','Color','b','LineStyle','none');
        
        hold off;
        
       % imagesc(log(handles.seriesarea)');

        guidata(hObject,handles);
        
%        set(ListSeries,'String',serieslist);
        
    end

    function sortlistclick(hObject,eventdata)
        handles=guidata(hObject);
        
        searchstring=get(e_searchstring,'String');        
        [handles.seriesarea,handles.seriesareaerror,serieslist]=sortmolecules(handles.molecules,searchstring);
        guidata(hObject,handles);
        
        set(ListSeries,'String',serieslist);
        
    end

    function writetopreviewedit(com,massoffset,resolution,area)
        set(e_com,'String',num2str(com));
        set(e_area,'String',num2str(area));
        set(e_massoffset,'String',num2str(massoffset));
        set(e_resolution,'String',num2str(resolution));
    end

    function updatecurrentmolecule()
      
        index=get(ListMolecules,'Value');

        handles=guidata(Parent);

        handles.ranges{rangeindex}.massoffset=str2double(get(e_massoffset,'String'));
        handles.ranges{rangeindex}.resolution=str2double(get(e_resolution,'String'));
        handles.molecules{rootindex}.area=str2double(get(e_area,'String'));
        handles.ranges{rangeindex}.molecules{moleculeindex}.area=str2double(get(e_area,'String'));
        
        handles.ranges(rangeindex)=calccomofranges(handles.ranges(rangeindex));
        
        set(e_com,'String',num2str(handles.ranges{rangeindex}.com));
        
        guidata(Parent,handles);
        
        plotpreview(rootindex);
        %fitpolynomials();
        plotdatapoints();
    end

    function parameterchange(hObject,eventdata)
        handles=guidata(hObject);
        tag=get(hObject,'Tag');
        switch tag
            case 'massoffsetup'
                value=str2double(get(e_massoffset,'String'));
                value=value+0.01;
                set(e_massoffset,'String',num2str(value));
            case 'massoffsetdown'
                value=str2double(get(e_massoffset,'String'));
                value=value-0.01;
                set(e_massoffset,'String',num2str(value));
            case 'resolutionup'
                value=str2double(get(e_resolution,'String'));
                value=value+0.05*value;
                set(e_resolution,'String',num2str(value));
            case 'resolutiondown'
                value=str2double(get(e_resolution,'String'));
                value=value-0.05*value;
                set(e_resolution,'String',num2str(value));
            case 'areaup'
                value=str2double(get(e_area,'String'));
                value=value+0.05*value;
                set(e_area,'String',num2str(value));   
            case 'areadown'
                value=str2double(get(e_area,'String'));
                value=value-0.05*value;
                set(e_area,'String',num2str(value));                
        end
        guidata(hObject,handles);
        updatecurrentmolecule();
    end

    function calibrationmenu(value1,value2)
        set(mcalbgc,'Enable',value1);
        set(mcalcal,'Enable',value2);
    end

    function menuloadmoleculesfolder(hObject,eventdata)
        handles=guidata(Parent);
        folder=uigetdir();
        
        if length(folder)>1 %cancel returns folder=0
            handles.molecules=loadmolecules(folder,foldertolist(folder),handles.peakdata);
            guidata(Parent,handles);
            molecules2listbox(ListMolecules,handles.molecules);
        end
        
        calibrationmenu('on','on');
    end

    function menuloadmoleculesifd(hObject,eventdata)
        handles=guidata(Parent);
        [filename, pathname, filterindex] = uigetfile( ...
            {'*.ifd','IsotopeFit data file (*.ifd)'},...
            'Open IsotopeFit data file');
        
        if ~(isequal(filename,0) || isequal(pathname,0))
            data={}; %load needs a predefined variable
            load(fullfile(pathname,filename),'-mat');
            
            handles.molecules=data.molecules;
        end
        guidata(Parent,handles);
        calibrationmenu('on','on');
    end

    function menubgcorrection(hObject,eventdata)
        handles=guidata(Parent);
        [handles.bgcorrectiondata, handles.startind, handles.endind]=bg_correction(handles.raw_peakdata,handles.bgcorrectiondata);    
        handles.peakdata=croppeakdata(handles.raw_peakdata,handles.startind, handles.endind);
        handles.peakdata=subtractbg(handles.peakdata,handles.bgcorrectiondata.bgpolynom);
        guidata(Parent,handles);
    end

    function menucalibration(hObject,eventdata)
        handles=guidata(Parent);
        
        peakdata=croppeakdata(handles.raw_peakdata,handles.startind, handles.endind);
        peakdata=subtractbg(peakdata,handles.bgcorrectiondata.bgpolynom);
        
        handles.calibration= calibrate(peakdata,handles.molecules,handles.calibration);
        handles.peakdata=subtractmassoffset(peakdata,handles.calibration);
        guidata(Parent,handles);
    end

    function open_file(hObject,eventdata)
        [filename, pathname, filterindex] = uigetfile( ...
            {'*.ifd','IsotopeFit data file (*.ifd)';...
            '*.h5','HDF5 data file (*.h5)';...
            '*.*','ASCII data file (*.*)'},...
            'Open IsotopeFit data file');
        handles=guidata(Parent);
        if ~(isequal(filename,0) || isequal(pathname,0))
            set(mmolecules,'Enable','on');
            switch filterindex
                case 1 %ifd
                    data={}; %load needs a predefined variable
                    load(fullfile(pathname,filename),'-mat');
                    
                    handles.raw_peakdata=data.raw_peakdata;
                    %handles.bgpolynom=data.bgpolynom;
                    handles.startind=data.startind;
                    handles.endind=data.endind;

                    % Background correction data
                    handles.bgcorrectiondata=data.bgcorrectiondata;
                    
                    handles.molecules=data.molecules;
                    
                    %Calibration data
                    handles.calibration=data.calibration;
                    
                    handles.peakdata=croppeakdata(handles.raw_peakdata,handles.startind, handles.endind);
                    handles.peakdata=subtractbg(handles.peakdata,handles.bgcorrectiondata.bgpolynom);
                    handles.peakdata=subtractmassoffset(handles.peakdata,handles.calibration);
                    
                    
                    guidata(Parent,handles);
                    
                    molecules2listbox(ListMolecules,handles.molecules);
                    
                    calibrationmenu('on','on');
                case 2 %h5
                    handles.raw_peakdata(:,1) = hdf5read(fullfile(pathname,filename),'/FullSpectra/MassAxis')';
                    handles.raw_peakdata(:,2) = hdf5read(fullfile(pathname,filename),'/FullSpectra/SumSpectrum')';
                    handles.startind=1;
                    handles.endind=size(handles.raw_peakdata,1);
                    handles.peakdata=handles.raw_peakdata;
                    
                    handles.calibration=standardcalibration;
                    
                    guidata(Parent,handles);
                    calibrationmenu('on','off');
                case 3 %ASCII
                    handles.raw_peakdata = load(fullfile(pathname,filename));
                    
                    handles.startind=1;
                    handles.endind=size(handles.raw_peakdata,1);
                    handles.peakdata=handles.raw_peakdata;
                    
                    handles.calibration=standardcalibration;
                    
                    guidata(Parent,handles);
                    calibrationmenu('on','off');
            end
            plot(dataaxes,handles.peakdata(:,1),handles.peakdata(:,2));
        end
    end

    function out=standardcalibration()
        out.comlist=[];
        out.massoffsetlist=[];
        out.resolutionlist=[];
        out.massoffsetmethode='Flat';
        out.resolutionmethode='Flat';
        out.massoffsetparam=0; %dont care for spline or pchip
        out.resolutionparam=3000; %flat calibration
        out.namelist={};
    end

    function save_file(hObject,eventdata)
        [filename, pathname, filterindex] = uiputfile( ...
            {'*.ifd','IsotopeFit data file (*.ifd)'
            '*.*', 'All Files (*.*)'},...
            'Save as');
        
        
        
        if ~(isequal(filename,0) || isequal(pathname,0))
            handles=guidata(Parent);
            
            data.raw_peakdata=handles.raw_peakdata;
            %data.bgpolynom=handles.bgpolynom;
            data.startind=handles.startind;
            data.endind=handles.endind;
            data.molecules=handles.molecules;
            data.calibration=handles.calibration;
            data.bgcorrectiondata=handles.bgcorrectiondata;
            
            save(fullfile(pathname,filename),'data');

         end
    end

    function moleculelistclick(hObject,eventdata)
        index=get(ListMolecules,'Value');
        
        plotmolecule(index);
    end

    function plotmolecule(index)
        handles=guidata(Parent);

        involvedmolecules=findinvolvedmolecules(handles.molecules,1:length(handles.molecules),index,0.3);
        
        com=calccomofmolecules(handles.molecules(involvedmolecules));

        ind = findmassrange(handles.peakdata(:,1)',handles.molecules(involvedmolecules),resolutionbycalibration(handles.calibration,com),0,30);
        
        calcmassaxis=handles.peakdata(ind,1)';
        
        resolutionaxis=resolutionbycalibration(handles.calibration,calcmassaxis);
        
        calcsignal=multispec(handles.molecules(index),...
            resolutionaxis,...
            0,...
            calcmassaxis);
            
        plot(dataaxes,handles.peakdata(:,1)',handles.peakdata(:,2)','Color',[0.5 0.5 0.5]);
        hold(dataaxes,'on');
        
        sumspectrum=multispec(handles.molecules(involvedmolecules),...
            resolutionaxis,...
            0,...
            calcmassaxis);
        plot(dataaxes,calcmassaxis,sumspectrum,'k--','Linewidth',2); 
        
        plot(dataaxes,calcmassaxis,calcsignal,'Color','red'); 
   
        %calculate and plot sum spectrum of involved molecules if current
        %molecule is in calibrationlist
        


        hold(dataaxes,'off');
        
        %Zoom data
        %[~,i]=max(handles.molecules{index}.peakdata(:,2));
 %       calcmassaxis
        xlim(dataaxes,[calcmassaxis(1),calcmassaxis(end)]);  
        %ylim(previewaxes,[0,max(max(handles.molecules{index}.peakdata(:,2)),max(handles.peakdata(handles.molecules{index}.minind:handles.molecules{index}.maxind,2)))]);
        
        guidata(Parent,handles);
    end

    function test(hObject,eventdata)
        folder='PET\allmolecules\';
        datafile='PET\1.txt';
        
        handles=guidata(Parent);
        
        %Load peakdata from ASCII file
        handles.raw_peakdata=load(datafile);
           
        
        [handles.bgcorrectiondata, handles.startind, handles.endind]=bg_correction(handles.raw_peakdata,handles.bgcorrectiondata);
        
        handles.peakdata=croppeakdata(handles.raw_peakdata,handles.startind, handles.endind);
        handles.peakdata=subtractbg(handles.peakdata,handles.bgcorrectiondata.bgpolynom);
        
        %Load molecules in Structure
        moleculelist=foldertolist(folder);
        handles.molecules=loadmolecules(folder,moleculelist,handles.peakdata);
        
        %do massoffset and resolution calibration
        handles.calibration= calibrate(handles.peakdata,handles.molecules,handles.calibration);
        
        handles.peakdata=subtractmassoffset(handles.peakdata,handles.calibration);
        
        plot(dataaxes, handles.peakdata(:,1),handles.peakdata(:,2));
        
        molecules2listbox(ListMolecules,handles.molecules);
        
        %Abspeichern der Struktur
        guidata(Parent,handles);
    end

    function out=croppeakdata(peakdata,ix1,ix2)
        out=peakdata(ix1:ix2,:);
    end

    function out=subtractbg(peakdata,bgpolynom)
        out=peakdata;
        out(:,2)=out(:,2)-polynomial(bgpolynom,peakdata(:,1));
    end

    function out=subtractmassoffset(peakdata,calibration)
        out=peakdata;
        mo=massoffsetbycalibration(calibration,peakdata(:,1));

        out(:,1)=out(:,1)-mo;
    end
    
    function [areaout,areaerrorout,sortlist]=sortmolecules(molecules,searchstring)
        searchstring=['[' searchstring ']'];
        
        attached={};
        for i=1:length(molecules)
            name=[molecules{i}.name '['];
            %find lineindex
            ix=strfind(name,searchstring);
            if isempty(ix)
                lineix=1;
                num='';
            else
                j=ix+length(searchstring);
                num='';
                while name(j)~='['
                    num=[num name(j)];
                    j=j+1;
                end
                if isempty(num)
                    lineix=2;
                else
                    lineix=str2num(num)+1;
                end
            end
            %find rowindex
            name=strrep(name,[searchstring num],'');
            ix=getnameidx(attached,name);
            if ix==0 %not found
                rowix=length(attached)+1;
                attached{rowix}=name;
            else
                rowix=ix;
            end
            areaout(lineix,rowix)=molecules{i}.area;
            areaerrorout(lineix,rowix)=molecules{i}.areaerror;
        end
        for i=1:length(attached)
            sortlist{i}=[searchstring 'n' attached{i}(1:end-1)];
        end
    end

    function fitbuttonclick(hObject,eventdata)
        handles=guidata(hObject);
        
        index=get(ListMolecules,'Value');
        
        ranges=findranges(handles.molecules,0.3);
                
        switch get(hObject,'String')
            case 'Fit this'
                involved=findinvolvedmolecules(handles.molecules,[1:length(handles.molecules)],index,0.3);
                handles.molecules(involved)=fitwithcalibration(handles.molecules(involved),handles.peakdata,handles.calibration);
                
            case 'Fit all'
                handles.molecules=fitwithcalibration(handles.molecules,handles.peakdata,handles.calibration);
        end
             guidata(hObject,handles);
        plotmolecule(index);
        
        
    end

end
