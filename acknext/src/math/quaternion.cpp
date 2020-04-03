#include "engine.hpp"
#include "../graphics/scene/ackglm.hpp"

QUATERNION * quat_temp(QUATERNION * q)
{
	if(q) { return q; }
	static QUATERNION buffer[ACKNEXT_TEMP_QUATERNIONS];
	static int index = 0;
	return &buffer[index++ % ACKNEXT_TEMP_QUATERNIONS];
}

ACKNEXT_API_BLOCK
{
	QUATERNION * euler(var pan, var tilt, var roll)
	{
		QUATERNION * q = quat_temp(nullptr);
		QUATERNION t;

		quat_axis_angle(&t, vector(0, 1, 0), pan);
		quat_set(q, &t);

		quat_axis_angle(&t, vector(1, 0, 0), tilt);
		quat_mult(q, &t);

		quat_axis_angle(&t, vector(0, 0, 1), roll);
		quat_mult(q, &t);

		return q;
	}

	QUATERNION * quat_id(QUATERNION * quat)
	{
		quat = quat_temp(quat);
		quat->x = 0;
		quat->y = 0;
		quat->z = 0;
		quat->w = 1;
		return quat;
	}

	QUATERNION * quat_set(QUATERNION * lhs, QUATERNION const * rhs)
	{
		*lhs = *rhs;
		return lhs;
	}

	QUATERNION * quat_axis_angle(QUATERNION * quat, VECTOR const * axis, var angle)
	{
		quat = quat_temp(quat);

		axis = vec_normalize(vec_clone(axis), 1.0f);
		angle *= DEG_TO_RAD;

		glm_to_ack(quat, glm::angleAxis(angle, ack_to_glm(*axis)));

		return quat;
	}

	QUATERNION * quat_mult(QUATERNION * lhs, QUATERNION const * rhs)
	{
		glm_to_ack(lhs, ack_to_glm(*lhs) * ack_to_glm(*rhs));
		return lhs;
	}
}
