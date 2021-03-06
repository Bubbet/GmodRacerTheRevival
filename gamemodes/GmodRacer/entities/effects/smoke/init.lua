function EFFECT:Init( data )

	self.EffectTimer = CurTime() + 0.001;
	
	local Offset = data:GetOrigin();
	local Size = data:GetScale();
 
 /*
 	local emitter = self:ParticleEmitter( Offset );
	if !emitter then
		GAMEMODE.StopEffects = true;
		timer.Simple(5, function ( ) GAMEMODE.StopEffects = false; end);
		return false;
	end
	*/
	
	local Health = math.Clamp((data:GetRadius() - 15) * 5, 0, 200);
	
	local Modifier = 1;
	
 	for i= 0, 1 do 
 		 			
		local particle1 = GAMEMODE.GlobalEmitter:Add( "particles/smokey", Offset );
		
		local Velocity = math.random(0,700);
		local Death = math.random(1,3) * Modifier;
		local Roll = math.random(0, 360);
		local RollDelta = math.random(-0.5, 0.5);
		local SetColor = math.random(Health, Health + 55);
		local StartAlpha = math.random(200,255);
		local Gravity = Vector(math.Rand(-100, 10), math.Rand(-100, 10), math.Rand(2, 400));
		
 		if particle1 then 
					
	 		particle1:SetVelocity(VectorRand() * Velocity);
	 				 
	 		particle1:SetLifeTime( 0 );
	 		particle1:SetDieTime(Death);
	 				 
	 		particle1:SetStartAlpha(StartAlpha);
	 		particle1:SetEndAlpha(0);
	 				 
	 		particle1:SetStartSize(math.Clamp(Size, 15, 300));
	 		particle1:SetEndSize(math.Clamp(Size, 30, 600) * 2 * (Modifier / 2));
						 				
	 		particle1:SetRoll(Roll);
	 		particle1:SetRollDelta(RollDelta);
	 				 
	 		particle1:SetAirResistance(400);
	 				 
	 		particle1:SetGravity(Vector(0, 0, 100));
			
			if GAMEMODE.IsNewRecord then
				particle1:SetColor(math.random(0, 255), math.random(0, 255), math.random(0, 255));
			else
				particle1:SetColor(SetColor, SetColor, SetColor);
			end
		end

 //	emitter:Finish();
	
	end
	
end

function EFFECT:ParticleEmitter( OffSet )
	if !self.Emitter then self.Emitter = ParticleEmitter(OffSet); end
	return self.Emitter
end

function EFFECT:Think( ) return false; end
function EFFECT:Render() end
