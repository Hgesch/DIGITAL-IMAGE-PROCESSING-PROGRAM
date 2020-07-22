%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%HANNA GESCHEIDLE
%PROJECT ONE
%EE 4323
%MAY 5, 2020
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
classdef ProjectOne < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                        matlab.ui.Figure
        UIAxes_before                   matlab.ui.control.UIAxes
        CurrentImageLabel               matlab.ui.control.Label
        LoadButton                      matlab.ui.control.Button
        BrightnessLabel                 matlab.ui.control.Label
        BrightnessSlider                matlab.ui.control.Slider
        ContrastLabel                   matlab.ui.control.Label
        ContrastSlider                  matlab.ui.control.Slider
        BrightnessConstantLabel         matlab.ui.control.Label
        BrightnessConstantEditField     matlab.ui.control.NumericEditField
        ContrastConstantEditFieldLabel  matlab.ui.control.Label
        ContrastConstantEditField       matlab.ui.control.NumericEditField
        PreviewImageLabel               matlab.ui.control.Label
        SpatialDomainFiltersLabel       matlab.ui.control.Label
        SpatialDomainFiltersDropDown    matlab.ui.control.DropDown
        BoostScaleLabel                 matlab.ui.control.Label
        BoostScaleEditField             matlab.ui.control.NumericEditField
        TestOneButton                   matlab.ui.control.Button
        ResizeImageHeightEditFieldLabel matlab.ui.control.Label
        ResizeImageHeightEditField      matlab.ui.control.NumericEditField
        TestTwoButton                   matlab.ui.control.Button
        TestThreeButton                 matlab.ui.control.Button
        MirrorLeftRightButton           matlab.ui.control.Button
        MirrorTopBottomButton           matlab.ui.control.Button
        ContrastExponentLabel           matlab.ui.control.Label
        ContrastExponentEditField       matlab.ui.control.NumericEditField
        FrequencyRangeLabel             matlab.ui.control.Label
        FrequencyRangeEditField         matlab.ui.control.NumericEditField
        toEditFieldLabel                matlab.ui.control.Label
        toEditField                     matlab.ui.control.NumericEditField
        UIAxes_after                    matlab.ui.control.UIAxes
        CutoffFrequencyRadiiLabel       matlab.ui.control.Label
        CutoffFrequencyRadiiEditField   matlab.ui.control.NumericEditField
        FrequencyDomainFiltersLabel     matlab.ui.control.Label
        FrequencyDomainFiltersDropDown  matlab.ui.control.DropDown
        RotateButton                    matlab.ui.control.Button
        WidthEditFieldLabel             matlab.ui.control.Label
        WidthEditField                  matlab.ui.control.NumericEditField
        SaveButton                      matlab.ui.control.Button
        UpdateButton                    matlab.ui.control.Button
        QuitButton                      matlab.ui.control.Button
    end

    % Callbacks that handle component events
    methods (Access = public)
        
        % Button pushed function: LoadButton
        function LoadButtonPushed(app, ~, ~)
            global CurrentImage PreviewImage
            [fileName,filePath] = uigetfile( ...
                {'*.jpg;*.bmp;*.png;*.gif;*.tiff;*.raw;',...
                'Common Image Files (*.jpg,*.bmp,*.png,*.gif,*.tiff,*.raw)';
                '*.*',  'All Files (*.*)'}, ...
                'Select Image to Display');
                      if isequal(fileName,0)
                          disp('[INFO] User cancelled file selection')
                      else
                          plot(app.UIAxes_before,[1 2 3 4],'-r');
                          hold(app.UIAxes_before);
                          plot(app.UIAxes_before,[10 9 4 7],'--b');
                          plot(app.UIAxes_after,[1 2 3 4],'-r');
                          hold(app.UIAxes_after);
                          plot(app.UIAxes_after,[10 9 4 7],'--b');
                          CurrentImage = imread(fullfile(filePath,fileName));
                          PreviewImage = CurrentImage;
                          imshow(CurrentImage,'Parent',app.UIAxes_before);
                          imshow(PreviewImage,'Parent',app.UIAxes_after);
                      end    
        end

        % Button pushed function: SaveButton
        function SaveButtonPushed(app, ~)
            global PreviewImage
            [savedFile,savedPath] = uiputfile;
            if isequal(savedFile,0)
                disp('[INFO] User cancelled file save operation')
            else
                fileName = fullfile(savedPath,savedFile);
                imwrite(PreviewImage,'Parent',app.UIAxes_after, fileName);
                sprintf('[INFO] User successfully saved file at: %f \n',fileName);
            end
        end
        
        % Button pushed function: UpdateButtonButton
        function UpdateButtonPushed(app, ~, ~)
             global CurrentImage PreviewImage
                CurrentImage = image(PreviewImage);
                cla(app.UIAxes_after);
                axes(app.UIAxes_before);
                imshow(CurrentImage, 'parent', app.UIAxes_before);
        end
      
        % Button pushed function: QuitButton
        function QuitButtonPushed(~, ~, ~)
          closereq(); 
        end

        % Value changed function: BrightnessSlider
        function BrightnessSliderValueChanged(app, ~)
            global BritSvalue PreviewImage CurrentImage
            BritSvalue = app.BrightnessSlider.Value;
            PreviewImage = BritSvalue + CurrentImage;
            cla(app.UIAxes_after);
            axes(app.UIAxes_after);
            imshow(PreviewImage, 'parent', app.UIAxes_after);
        end  
        
        % Value changed function: BrightnessEditField
        function BrightnessConstantEditFieldValueChanged(app,~,~)
            global BritEvalue PreviewImage CurrentImage
            BritEvalue = app.BrightnessConstantEditField.Value;
            PreviewImage = BritEvalue + CurrentImage;
            cla(app.UIAxes_after);
            axes(app.UIAxes_after);
            imshow(PreviewImage, 'parent', app.UIAxes_after);
        end
        
        % Value changed function: ContrastSlider
        function ContrastSliderValueChanged(app,~,~)
            global ConSvalue PreviewImage CurrentImage
            ConSvalue = app.ContrastSlider.Value;
            PreviewImage = CurrentImage * ConSvalue;
            cla(app.UIAxes_after);
            axes(app.UIAxes_after);
            imshow(PreviewImage, 'parent', app.UIAxes_after);
        end   
        
        % Value changed function: ContrastEditField
        function ContrastConstantEditFieldValueChanged(app,~,~)
            global PreviewImage CurrentImage
            ConEvalue = app.ContrastConstantEditField.Value;
            PreviewImage = CurrentImage * ConEvalue;
            cla(app.UIAxes_after);
            axes(app.UIAxes_after);
            imshow(PreviewImage, 'parent', app.UIAxes_after);
        end
        
        function ContrastExponentEditFieldValueChanged(app, ~, ~)
            global PreviewImage CurrentImage ConExp
            ConExp = app.ContrastExponentEditField.Value;
            PreviewImage = CurrentImage - exp(ConExp);
            cla(app.UIAxes_after);
            axes(app.UIAxes_after);
            imshow(PreviewImage, 'parent', app.UIAxes_after);
        end
        
        %TEST 1:
        function TestOneButtonPushed(app, ~, ~)
            global PreviewImage
            PreviewImage = zeros(256,256,'uint8');

                for i=1:256
                    for j=2:256
                        PreviewImage(i,j)=150;
                    end
                end
                cla(app.UIAxes_after);
                axes(app.UIAxes_after);
                imshow(PreviewImage, 'parent', app.UIAxes_after);
            end
            
        %TEST 2:
            function TestTwoButtonPushed(app,~,~)
                global PreviewImage
                    PreviewImage = zeros(256,256,'uint8');
                        for i=1:256
                            for j=2:256
                            PreviewImage(i,j)=i-1;
                            end
                        end
                cla(app.UIAxes_after);
                axes(app.UIAxes_after);
                imshow(PreviewImage, 'parent', app.UIAxes_after);
            end

            %TEST 3:
            function TestThreeButtonPushed(app,~,~)
                global PreviewImage
                    PreviewImage = zeros(256,256,'uint8');
                    for i=1:256
                        for j=2:256
                        PreviewImage(i,j)=j-1;
                        end
                    end     
                cla(app.UIAxes_after);
                axes(app.UIAxes_after);
                imshow(PreviewImage, 'parent', app.UIAxes_after)
            end
        
            % Button pushed function: RotateButton
            function RotateButtonPushed(app, ~, ~)
                global PreviewImage
                PreviewImage=imrotate(PreviewImage, 90);
                cla(app.UIAxes_after);
                axes(app.UIAxes_after);
                imshow(PreviewImage, 'Parent', app.UIAxes_after)
            end

            % Create MirrorLeftRightButton
            function MirrorLeftRightButtonPushed(app, ~, ~)
                global PreviewImage
                PreviewImage = [PreviewImage,fliplr(PreviewImage)];
                cla(app.UIAxes_after);
                axes(app.UIAxes_after);
                imshow(PreviewImage,'Parent',app.UIAxes_after);    
            end

            % Create MirrorTopBottomButton
            function MirrorTopBottomButtonPushed(app, ~, ~)
                global PreviewImage
                  PreviewImage = [PreviewImage;flipud(PreviewImage)];
                  cla(app.UIAxes_after);
                  axes(app.UIAxes_after);
                  imshow(PreviewImage,'Parent',app.UIAxes_after);
            end    

            % Value changed function: ResizeImageHeightEditField
            function ResizeImageHeightEditFieldValueChanged(app, ~, ~)
                global  height width
                height = app.ResizeImageHeightEditField.Value;
                width = app.WidthEditField.Value;
            end

            % Value changed function: WidthEditField
            function WidthEditFieldValueChanged(app, ~, ~)
                global PreviewImage height width
                height = app.ResizeImageHeightEditField.Value;
                width = app.WidthEditField.Value;
                PreviewImage = imresize(PreviewImage, [height width]);
                cla(app.UIAxes_after);
                axes(app.UIAxes_after);
                imshow(PreviewImage,'parent',app.UIAxes_after);
            end
    end

    % Component initialization
    methods (Access = public)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Position = [100 100 651 559];
            app.UIFigure.Name = 'UI Figure';
            setAutoResize(app, app.UIFigure, true)

            % Create UIAxes_before
            app.UIAxes_before = uiaxes(app.UIFigure);
            app.UIAxes_before.XTick = [];
            app.UIAxes_before.XTickLabel = {'[ ]'};
            app.UIAxes_before.YTick = [];
            app.UIAxes_before.Position = [4 328 318 228];

            % Create UIAxes_after
            app.UIAxes_after = uiaxes(app.UIFigure);
            app.UIAxes_after.XTick = [];
            app.UIAxes_after.XTickLabel = {'[ ]'};
            app.UIAxes_after.YTick = [];
            app.UIAxes_after.Position = [325 328 318 228];
            
            % Create CurrentImageLabel
            app.CurrentImageLabel = uilabel(app.UIFigure);
            app.CurrentImageLabel.FontWeight = 'bold';
            app.CurrentImageLabel.Position = [127 309 88 22];
            app.CurrentImageLabel.Text = 'Current Image';

            % Create LoadButton
            app.LoadButton = uibutton(app.UIFigure, 'push');
            app.LoadButton.ButtonPushedFcn = createCallbackFcn(app, @LoadButtonPushed, true);
            app.LoadButton.Position = [4 7 61 22];
            app.LoadButton.Text = 'Load';

            % Create BrightnessLabel
            app.BrightnessLabel = uilabel(app.UIFigure);
            app.BrightnessLabel.HorizontalAlignment = 'right';
            app.BrightnessLabel.Position = [1 227 70 22];
            app.BrightnessLabel.Text = 'Brightness: ';

            % Create BrightnessSlider
            app.BrightnessSlider = uislider(app.UIFigure);
            app.BrightnessSlider.Limits = [-100 100];
            app.BrightnessSlider.ValueChangedFcn = createCallbackFcn(app, @BrightnessSliderValueChanged, true);
            app.BrightnessSlider.Position = [75 237 247 3];

            % Create ContrastLabel
            app.ContrastLabel = uilabel(app.UIFigure);
            app.ContrastLabel.HorizontalAlignment = 'right';
            app.ContrastLabel.Position = [4 124 58 22];
            app.ContrastLabel.Text = 'Contrast: ';

            % Create ContrastSlider
            app.ContrastSlider = uislider(app.UIFigure);
            app.ContrastSlider.ValueChangedFcn = createCallbackFcn(app, @ContrastSliderValueChanged, true);
            app.ContrastSlider.Position = [76 134 250 3];

            % Create BrightnessConstantLabel
            app.BrightnessConstantLabel = uilabel(app.UIFigure);
            app.BrightnessConstantLabel.HorizontalAlignment = 'right';
            app.BrightnessConstantLabel.Position = [4 158 122 22];
            app.BrightnessConstantLabel.Text = 'Brightness Constant: ';

            % Create BrightnessConstantEditField
            app.BrightnessConstantEditField = uieditfield(app.UIFigure, 'numeric');
            app.BrightnessConstantEditField.ValueChangedFcn = createCallbackFcn(app, @BrightnessConstantEditFieldValueChanged, true);
            app.BrightnessConstantEditField.Position = [134 158 48 22];

            % Create ContrastConstantEditFieldLabel
            app.ContrastConstantEditFieldLabel = uilabel(app.UIFigure);
            app.ContrastConstantEditFieldLabel.HorizontalAlignment = 'right';
            app.ContrastConstantEditFieldLabel.Position = [6 56 107 22];
            app.ContrastConstantEditFieldLabel.Text = 'Contrast Constant: ';

            % Create ContrastConstantEditField
            app.ContrastConstantEditField = uieditfield(app.UIFigure, 'numeric');
            app.ContrastConstantEditField.ValueChangedFcn = createCallbackFcn(app, @ContrastConstantEditFieldValueChanged, true);
            app.ContrastConstantEditField.Position = [114 56 48 22];

            % Create PreviewImageLabel
            app.PreviewImageLabel = uilabel(app.UIFigure);
            app.PreviewImageLabel.FontWeight = 'bold';
            app.PreviewImageLabel.Position = [436 308 86 21];
            app.PreviewImageLabel.Text = 'Preview Image';

            % Create TestOneButton
            app.TestOneButton = uibutton(app.UIFigure, 'push');
            app.TestOneButton.ButtonPushedFcn = createCallbackFcn(app, @TestOneButtonPushed, true);
            app.TestOneButton.Position = [37 262 46 36];
            app.TestOneButton.Text = {'Test'; 'One'};

            % Create SaveButton
            app.SaveButton = uibutton(app.UIFigure, 'push');
            app.SaveButton.ButtonPushedFcn = createCallbackFcn(app, @SaveButtonPushed, true);
            app.SaveButton.Position = [98 7 61 22];
            app.SaveButton.Text = 'Save';

            % Create UpdateButton
            app.UpdateButton = uibutton(app.UIFigure, 'push');
            app.UpdateButton.ButtonPushedFcn = createCallbackFcn(app, @UpdateButtonPushed, true);
            app.UpdateButton.Position = [181 7 61 22];
            app.UpdateButton.Text = 'Update';

            % Create QuitButton
            app.QuitButton = uibutton(app.UIFigure, 'push');
            app.QuitButton.ButtonPushedFcn = createCallbackFcn(app, @QuitButtonPushed, true);
            app.QuitButton.Position = [270 7 61 22];
            app.QuitButton.Text = 'Quit';

            % Create ResizeImageHeightEditFieldLabel
            app.ResizeImageHeightEditFieldLabel = uilabel(app.UIFigure);
            app.ResizeImageHeightEditFieldLabel.HorizontalAlignment = 'right';
            app.ResizeImageHeightEditFieldLabel.Position = [352 223 129 22];
            app.ResizeImageHeightEditFieldLabel.Text = 'Resize Image:   Height ';

            % Create ResizeImageHeightEditField
            app.ResizeImageHeightEditField = uieditfield(app.UIFigure, 'numeric');
            app.ResizeImageHeightEditField.ValueChangedFcn = createCallbackFcn(app, @ResizeImageHeightEditFieldValueChanged, true);
            app.ResizeImageHeightEditField.Position = [481 224 51 22];

            % Create WidthEditFieldLabel
            app.WidthEditFieldLabel = uilabel(app.UIFigure);
            app.WidthEditFieldLabel.HorizontalAlignment = 'right';
            app.WidthEditFieldLabel.Position = [536 223 49 22];
            app.WidthEditFieldLabel.Text = 'Width ';

            % Create WidthEditField
            app.WidthEditField = uieditfield(app.UIFigure, 'numeric');
            app.WidthEditField.ValueChangedFcn = createCallbackFcn(app, @WidthEditFieldValueChanged, true);
            app.WidthEditField.Position = [587 226 51 19];

            % Create TestTwoButton
            app.TestTwoButton = uibutton(app.UIFigure, 'push');
            app.TestTwoButton.ButtonPushedFcn = createCallbackFcn(app, @TestTwoButtonPushed, true);
            app.TestTwoButton.Position = [140 262 46 36];
            app.TestTwoButton.Text = {'Test'; 'Two'};

            % Create TestThreeButton
            app.TestThreeButton = uibutton(app.UIFigure, 'push');
            app.TestThreeButton.ButtonPushedFcn = createCallbackFcn(app, @TestThreeButtonPushed, true);
            app.TestThreeButton.Position = [245 262 46 36];
            app.TestThreeButton.Text = {'Test'; 'Three'};

            % Create RotateButton
            app.RotateButton = uibutton(app.UIFigure, 'push');
            app.RotateButton.ButtonPushedFcn = createCallbackFcn(app, @RotateButtonPushed, true);
            app.RotateButton.Position = [561 262 51 36];
            app.RotateButton.Text = 'Rotate';

            % Create MirrorLeftRightButton
            app.MirrorLeftRightButton = uibutton(app.UIFigure, 'push');
            app.MirrorLeftRightButton.ButtonPushedFcn = createCallbackFcn(app, @MirrorLeftRightButtonPushed, true);
            app.MirrorLeftRightButton.Position = [454 262 61 36];
            app.MirrorLeftRightButton.Text = {'Mirror:'; 'Left/Right'};

            % Create MirrorTopBottomButton
            app.MirrorTopBottomButton = uibutton(app.UIFigure, 'push');
            app.MirrorTopBottomButton.ButtonPushedFcn = createCallbackFcn(app, @MirrorTopBottomButtonPushed, true);
            app.MirrorTopBottomButton.Position = [352 262 72 36];
            app.MirrorTopBottomButton.Text = {'Mirror:'; 'Top/Bottom'};

            % Create ContrastExponentLabel
            app.ContrastExponentLabel = uilabel(app.UIFigure);
            app.ContrastExponentLabel.HorizontalAlignment = 'right';
            app.ContrastExponentLabel.Position = [168 56 113 22];
            app.ContrastExponentLabel.Text = 'Contrast Exponent: ';

            % Create ContrastExponentEditField
            app.ContrastExponentEditField = uieditfield(app.UIFigure, 'numeric');
            app.ContrastExponentEditField.ValueChangedFcn = createCallbackFcn(app, @ContrastExponentEditFieldValueChanged, true);
            app.ContrastExponentEditField.Position = [290 56 48 22];

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = ProjectOne

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.UIFigure)
        end
    end
end